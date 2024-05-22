creat table author(id int AUTO_INCREMENT, name varchar(255), email varchar(255) not null,
created_time datetime DEFAULT current_timestamp, PRIMARY key(id), unique(email));

create table post(id AUTO_INCREMENT, title varchar(255) not null,
contents varchar(255), PRIMARY key(id));

create table author_address(id int AUTO_INCREMENT,country varchar(255), city varchar(255),
 street varchar(255), author_id int not null,primary key(id), unique(author_id),
 foreign key(author_id) references author(id), on delete cascade);

 create table author_post(id int auto_increment primary key, author_id int not null,
 post_id int not null, foreign key(author_id) references author(id),
 foreign key(post_id) references post(id));