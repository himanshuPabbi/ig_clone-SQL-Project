use ig_clone;

#We want to reward the user who has been around the longest, Find the 5 oldest users.
select * from users order by created_at limit 5;

#To target inactive users in an email ad campaign, find the users who have never posted a photo.

#using co-related sub-quaries 
select * from users u where not exists(
select * from photos p where u.id=p.user_id);

#OR using non co-related sub-quaries 
select * from users u where id not in(select user_id from photos);

#Suppose you are running a contest to find out who got the most likes on a photo. Find out who won?

select count(users.id) Total,users.id,username as user_id from users 
inner join likes on users.id=likes.user_id
inner join photos on photos.user_id=likes.user_id
group by users.id order by count(users.id) desc limit 1;


#A brand wants to know which hashtag to use on a post, and find the top 5 most used hashtags.
select tag_name,count(tag_name) from tags 
inner join photo_tags on tags.id=photo_tags.tag_id
group by tag_name order by count(tag_name) desc limit 5;


#The investors want to know how many times does the average user post.
create view Avg_post as(
select users.id,count(users.id) as user_post from users 
inner join photos on users.id=photos.user_id
group by users.id);
select round(avg(user_post)) from Avg_post;

#OR
select round(avg(user_post)) from (
select users.id,count(users.id) as user_post from users 
inner join photos on users.id=photos.user_id
group by users.id) p;

#Can you help me find the users whose name starts with c and ends with any number and have posted the photos as well as liked the photos?
select * from users 
inner join photos on users.id=photos.user_id
inner join likes on likes.user_id=users.id
where username like 'c%';


#Demonstrate the top 30 usernames to the company who have posted photos in the range of 3 to 5.
select count(users.id) as Photo_Post_count,users.username from users 
inner join photos on users.id=photos.user_id 
group by users.id having count(users.id)
between 3 and 5 limit 30;


#Find the users who have created instagramid in may and select top 5 newest joinees from it?
select * from users where month(created_at)=5 
order by created_at desc limit 5;


#To find out if there are bots, find users who have liked every single photo on the site.
select * from users where id =all(
select user_id from photos);


