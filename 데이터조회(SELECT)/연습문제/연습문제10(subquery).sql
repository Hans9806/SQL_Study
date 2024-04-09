-- 서브쿼리 문제
-- sakila 데이터베이스 사용
USE sakila;
-- 문제1. 총 결제 금액이 $100을 초과하는 모든 고객의 이름과 성을 조회하세요.
-- 사용 테이블: customer (customer_id, first_name, last_name), payment (payment_id, customer_id, amount)
SELECT c.first_name, c.last_name
FROM customer c
WHERE c.customer_id 
IN(SELECT p.customer_id FROM payment p GROUP BY p.customer_id HAVING sum(p.amount) > 100);
-- 문제2. 5개 이상의 영화를 대여한 모든 고객의 이름과 성을 조회하세요.
-- 사용 테이블: customer (customer_id, first_name, last_name), rental (rental_id, customer_id)
SELECT c.first_name, c.last_name
FROM customer c
WHERE c.customer_id 
IN(SELECT r.customer_id FROM rental r GROUP BY r.customer_id HAVING count(*) >=5);
-- 문제3. 5편 이상의 영화에 출연한 모든 배우의 이름과 성을 조회하세요.
-- 사용 테이블: actor (actor_id, first_name, last_name), film_actor (actor_id, film_id)
SELECT a.first_name, a.last_name
FROM actor a
WHERE a.actor_id
IN(SELECT fa.actor_id FROM film_actor fa GROUP BY fa.actor_id HAVING count(*) >= 5);
-- 문제4. 평균 영화 길이보다 긴 모든 영화의 제목을 조회하세요.
-- 사용 테이블: film (film_id, title, length)
DESC film;
SELECT f.title
FROM film f
WHERE f.length > (SELECT avg(length) FROM film);
-- 문제5. 평균 대여 비용보다 높은 대여 비용을 가진 모든 영화의 제목과 대여 비용을 조회하세요.
-- 사용 테이블: film (film_id, title, rental_rate)
SELECT f.title, f.rental_rate
FROM film f
WHERE f.rental_rate > (SELECT avg(rental_rate) FROM film);
-- 문제6. 각 영화에 출연한 배우의 수와 함께 영화 제목을 조회하세요. (SELECT절 사용)
-- 사용 테이블: film (film_id, title), film_actor (actor_id, film_id)
SELECT f.title, (SELECT count(*) FROM film_actor fa WHERE fa.film_id = f.film_id) as actor_count
FROM film f;
-- 문제7. 단일 고객이 가장 많이 대여한 영화 수를 조회하세요. (FROM절 사용)
-- 사용 테이블: rental (rental_id, customer_id)
DESC rental;
SELECT max(rental_count)
FROM (
	SELECT customer_id, count(*) as rental_count
	FROM rental
    GROUP BY customer_id) as rental_count;