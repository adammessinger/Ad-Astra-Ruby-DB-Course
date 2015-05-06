#Intro to Ruby & Databases Week 3, Day 1

We've been storing data for our programs in RAM, which is fast but limited and 
temporary. When it's time for long-term storage, what we probably want is a 
database.

##Types of Databases

###Relational Databases

Also known as Relational Database Management Systems (RDBMS). Some of the big 
names in this category:

* MySQL
* PostgreSQL
* Microsoft SQL Server
* SQLite

###Non-Relational Databases

This is a big category that includes document stores, key-value databases, graph 
databases, etc. For example:

* MongoDB
* Cassandra
* CouchDB
* InfiniteGraph

##Database Relations

First, a little review. Databases are kind of like a bunch of spreadsheets, 
related to each other by the fields they share in common. For example:

```
friends
-------

 id | name    | phone
 ---+---------+-----------
 1  | Chris   | 9165551212
 2  | Jessica | 3235551212
 3  | Jake    | 4155551212
 ```

Each "spreadsheet" is called a **table**, and the relationships between them 
generally take three forms.

###One-to-Many Relationships

One of the principles of good database design is minimizing data redundancy. 
This is **database normalization**. For example, the people in the `friends` 
table above could have more than one phone number. We could show that by adding 
another column, but it would be better to store the data in two tables with a 
**one-to-many relationship**:

```
friends
-------

 id | name
 ---+--------
  1 | Chris
  2 | Jessica
  3 | Jake

phones
------

 id | number     | type | friend_id
 ---+------------+------+----------
  1 | 9165551212 | cell | 1
  2 | 3235551212 | cell | 2
  3 | 4155551212 | cell | 3
  4 | 9165552020 | work | 1
  5 | 3235552020 | work | 2
  6 | 4155552020 | work | 3
```

The `id` field in each of these tables is the **primary key** for that table. 
The `friend_id` field in the `phones` table is an example of a **foreign key**.

###Many-to-Many Relationships

What if we want to track what cities my friends have visited?

```
friends
-------

 id | name    | phone
 ---+---------+-----------
 1  | Chris   | 9165551212
 2  | Jessica | 3235551212
 3  | Jake    | 4155551212


cities
------

 id | city     | state | friend_id
 ---+----------+-------+----------
  1 | Chicago  | IL    | 1
  2 | New York | NY    | 1
  3 | Oakland  | CA    | 2
  4 | Portland | OR    | 3
```

Okay, but what if Jessica and Jake both go to Chicago?

```
cities
------

 id | city     | state | friend_id
 ---+----------+-------+----------
  1 | Chicago  | IL    | 1
  2 | New York | NY    | 1
  3 | Oakland  | CA    | 2
  4 | Portland | OR    | 3
  5 | Chicago  | IL    | 2
  5 | Chicago  | IL    | 3
```

That's no good. If we have to update Chicago, we'll have to edit it in multiple 
places. We no longer have a one-to-many relationship, in which one person can 
visit many cities; it should be a many-to-many relationship, in which one person 
can visit many cities, and one city can have many people visit it. The right way 
to handle this is a **join table**:

```
friends
-------

 id | name    | phone
 ---+---------+-----------
 1  | Chris   | 9165551212
 2  | Jessica | 3235551212
 3  | Jake    | 4155551212


cities
------

 id | city     | state
 ---+----------+------
 1  | Chicago  | IL
 2  | New York | NY
 3  | Oakland  | CA
 4  | Portland | OR


friends_cities
--------------

 id | city_id | friend_id
 ---+---------+----------
 1  | 1       | 1
 2  | 1       | 2
 3  | 2       | 3
 4  | 2       | 1
```

`friends_cities` holds IDs from both tables that it joins, so that you can have 
any combination of IDs from both tables without duplicating data. 

If you can't think of a better name for a join table, you can just use the names 
of the two tables it joins separated by an underscore. But it's nice to think of 
something more descriptive. For this join table, `visits` might be a better name.

###One-to-One Relationships

There are also **one-to-one relationships**, for example between a person and 
their Social Security number. These aren't used much, because the information 
can just be combined into one table. They might be useful for clarity, 
separation of concerns, or performance (for example keeping BLOBs in their own 
table).

##Schema Diagrams

These are graphics that show tables, their fields, and the relationships between 
them. Check out [SQL Designer](http://ondras.zarovi.cz/sql/demo/) for an example.

##SQL Basics

See the [course material](https://canvas.instructure.com/courses/922390/pages/sql-basics?module_item_id=7145472) for more examples, `SELECT` examples using `LIKE`
 and `BETWEEN`, and more.

###Putting Data In

**NOTE:** You can do most of the schema creation stuff with a GUI, and that's
probably far easier for anything complex.

```
contacts
--------

key      | type
-----------------------
id (PK)  | integer
name     | varchar (64)
age      | integer
birthday | timestamp
```

Created like so:

```sql
CREATE TABLE contacts (
  name varchar,
  age int,
  birthday timestamp
);
```

To delete a table:

```sql
DROP TABLE contacts;
```

Let's say we want to add a boolean field to track whether each contact is a 
family member...

```sql
ALTER TABLE contacts ADD family boolean;
```

You can drop a table column similar to how you drop tables:

```sql
ALTER TABLE contacts DROP family;
```

Oops! We forgot our primary key called `id`, so let's add that using the special 
`serial` data type (for auto-incrementing integers):

```sql
ALTER TABLE contacts ADD id serial PRIMARY KEY;
```

Now let's finally add some data. The `id` will be automatically added for us, 
and the string time will be automatically converted into a timestamp.

```sql
INSERT INTO contacts (name, age, birthday) VALUES ('Wes', 43, '1969-05-01');
```

###Getting Data Out

Most of the time, data will be inserted into the DB once and read out many times.
For this we'll be using the `SELECT` command.


```sql
SELECT name FROM contacts;

 name
------
 Wes
 Wes
 Wes
(3 rows)

SELECT name, birthday FROM contacts;

 name |      birthday
------+---------------------
 Wes  | 1969-05-01 00:00:00
 Wes  | 1969-05-01 00:00:00
 Wes  | 1969-05-01 00:00:00
(3 rows)

SELECT * FROM contacts;

 name | age |      birthday       | id
------+-----+---------------------+----
 Wes  |  43 | 1969-05-01 00:00:00 |  1
 Wes  |  43 | 1969-05-01 00:00:00 |  2
 Wes  |  43 | 1969-05-01 00:00:00 |  3
(3 rows)
```

With some conditions, you can narrow things down:

```sql
SELECT id, name FROM contacts WHERE age = 21;
```

###Updating Data

What if we need to change data in our database? There are a lot of fancy ways to 
do this, but let's focus on the simplest and most common: select a record by its 
primary key, and update its data:

```sql
UPDATE contacts SET name = 'Wes Anderson' WHERE id = 1;
```

Now, let's delete a record:

```sql
DELETE FROM contacts WHERE id = 1;
```

###Comments in SQL

```sql
/* this is a comment
   spanning multiple lines */

-- this is a one-line comment
```

###Some PostreSQL Quote Quirks

PostgreSQL requires that you use single quotes around non-int values. If you're 
trying to use a column name that contains illegal characters, you surround it 
with double quotes.

##Using SQL with Ruby

A lot of apps that use a database have operations described by the acronym 
CRUD: Create, Read, Update, Delete. Ruby provides a tool for simplifying such 
operations in Postgres using the `pg` gem: `gem install pg`.

```ruby
require 'pg'

address_book_db = PG.connect({:dbname => 'address_book'})
address_book_db.exec "INSERT INTO contacts (name) VALUES ('Mike')"

results = address_book_db.exec("SELECT * FROM address_book")
results.each { |result| puts result.name }
```

Pretty simple -- the argument passed to the `exec` method is a SQL statement you 
want to run. The results come back is a `PG::Result` object -- a collection of 
hashes you can iterate over.

**NOTE:** Had a hell of a time getting PG to work. The current 
[RailsInstaller](http://railsinstaller.org/) package that comes with Ruby 2.1.5
includes PG 0.17.1, which is [only compatible with Ruby 2.0 and older](https://bitbucket.org/ged/ruby-pg/issue/182/pg-gem-error-under-ruby-210-in-rails-41).
Upgrading to PG 0.18.1 didn't fix the problem. The ultimate solution was to 
remove RailsInstaller from my system and install their Ruby 2.0.0 package. This
also required re-fixing the RubyGems issue encountered in Week 1, Day 2.
