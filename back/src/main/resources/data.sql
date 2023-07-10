INSERT INTO product (id, name, price, type) VALUES
(1,	'glace chocolat',	2,	'DESSERT'),
(2,	'cote de port',	4.99,	'MAIN'),
(3,	'frite',	2.50,	'MAIN'),
(4,	'salade',	1.99,	'ENTRY'),
(5,	'paté',	2,	'ENTRY'),
(6,	'coca cola',	3.99,	'DRINK');

INSERT INTO user_resto (admin, firstname, lastname, login, password)
VALUES ('0', 'test', 'test', 'test', '$2y$10$H9KrDMnXt47q3JsM1kr32uSrfDjfyzMwThxCtEcnJX5oXdlqc/XFS'),
('1', 'admin', 'admin', 'admin', '$2y$10$t9CyLKjl3HFZWYXQ51mmXuPFd1iu5D6rMIHSKMTBv0ZJZvNkQ9jTi');
