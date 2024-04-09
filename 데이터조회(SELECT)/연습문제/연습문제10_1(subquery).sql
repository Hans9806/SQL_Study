-- 문제1. 총 결제 금액이 $100을 초과하는 모든 고객의 이름과 성을 조회하세요. (IN)
-- 사용 테이블: customer (customer_id, first_name, last_name), payment (payment_id, customer_id, amount)
select * from payment;

-- 메인쿼리
SELECT 
    first_name, last_name
FROM
    customer
WHERE
    customer_id IN (SELECT 
            customer_id
        FROM
            payment
        GROUP BY customer_id
        HAVING SUM(amount) > 100);

-- 서브쿼리
SELECT customer_id, sum(amount) FROM payment GROUP BY customer_id HAVING sum(amount) > 100;

-- 문제2. 5개 이상의 영화를 대여한 모든 고객의 이름과 성을 조회하세요. (IN)
-- 사용 테이블: customer (customer_id, first_name, last_name), rental (rental_id, customer_id)
-- 메인쿼리;
select first_name, last_name from customer where customer_id in (서브쿼리);
SELECT 
    first_name, last_name
FROM
    customer
WHERE
    customer_id IN (SELECT 
            customer_id
        FROM
            rental
        GROUP BY customer_id
        HAVING COUNT(rental_id) > 5);
-- 서브쿼리
SELECT customer_id, count(rental_id) from rental 
group by customer_id HAVING count(rental_id) > 5;

-- 문제3. 5편 이상의 영화에 출연한 모든 배우의 이름과 성을 조회하세요. (IN)
-- 사용 테이블: actor (actor_id, first_name, last_name), film_actor (actor_id, film_id)

-- 메인쿼리
SELECT first_name, last_name from actor where actor_id in (서브쿼리);

SELECT 
    first_name, last_name
FROM
    actor
WHERE
    actor_id IN (SELECT 
            actor_id
        FROM
            film_actor
        GROUP BY actor_id
        HAVING COUNT(film_id) >= 5);
-- 서브쿼리
SELECT actor_id, count(film_id) from film_actor GROUP BY actor_id HAVING count(film_id) >= 5;

-- 문제4. 평균 영화 길이보다 긴 모든 영화의 제목을 조회하세요. 
-- 사용 테이블: film (film_id, title, length)
-- 메인
select title from film where length > (서브쿼리);
-- 서브
select avg(length) from film;

SELECT 
    title
FROM
    film
WHERE
    length > (SELECT 
            AVG(length)
        FROM
            film);
            
-- 문제5. 평균 대여 비용보다 높은 대여 비용을 가진 모든 영화의 제목과 대여 비용을 조회하세요.
-- 사용 테이블: film (film_id, title, rental_rate)
SELECT avg(rental_rate) from film;
SELECT
    title, rental_rate
FROM
    film
WHERE
    rental_rate > (SELECT
            AVG(rental_rate)
        FROM
            film);

-- 문제6. 각 영화에 출연한 배우의 수와 함께 영화 제목을 조회하세요. (SELECT절 사용)
-- 사용 테이블: film (film_id, title), film_actor (actor_id, film_id)
select f.title,
	   ( select count(fa.actor_id)
       from film_actor fa
       where fa.film_id = f.film_id ) as '배우의 수'
from film f;

SELECT 
    MAX(r_count)
FROM
    (SELECT 
        customer_id, COUNT(rental_id) AS r_count
    FROM
        rental
    GROUP BY customer_id) AS rent_count;