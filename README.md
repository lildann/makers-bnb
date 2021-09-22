# MakersBnB specification

We would like a web application that allows users to list spaces they have available, and to hire spaces for the night.

### Headline specifications
1. Any signed-up user can list a new space.
2. Users can list multiple spaces.
3. Users should be able to name their space, provide a short description of the space, and a price per night.
4. Users should be able to offer a range of dates where their space is available.
5. Any signed-up user can request to hire any space for one night, and this should be approved by the user that owns that space.
6. Nights for which a space has already been booked should not be available for users to book that space.
7. Until a user has confirmed a booking request, that space can still be booked for that night.

### User stories
```
As a user
So that I can add new spaces
I want to list a property

As a user
So that I have a profile that remembers me
I want to log in

As a user
So that I can market my property
I would like to have provide information on my space 
(Name, description, price per night)

As a user
So that I can see availabilty 
I would like to offer a range of dates to book

As a user
So that I have control over my bookings
I can accept or decline the request to book

As a user
So that double booking is avoided
The property can not be booked if it is already booked

In development:
As part of the booking system
So that I can still book a property which is not yet confirmed 
I can book a property which is pending confirmation 
```


Instructions for Database Setup and Test Database Setup
----
* Connect to psql
* Create the two databases using the psql command: 
```
CREATE DATABASE bnb;
CREATE DATABASE bnb_test;
```
* Connect to each database using the pqsl command 
```
\c bnb;
\c bnb_test;
```
* To setup the approriate tables, run the SQL script saved in the `db/migrations` folder in the given order (file 01_create_users_table.sql)


### To run the Bnb app:

```
rackup -p 3000
```
