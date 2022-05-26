DROP DATABASE IF EXISTS shoe_db;

CREATE DATABASE shoe_db;

GRANT ALL PRIVILEGES ON shoe_db.* to grader@localhost IDENTIFIED BY 'allowme';

USE shoe_db;

CREATE TABLE Sizes(
  sizes INTEGER,
  gender VARCHAR(10),
  PRIMARY KEY (sizes)
);

CREATE TABLE Brand(
  brand VARCHAR(20),
  type VARCHAR(10),
  PRIMARY KEY(brand)
);

CREATE TABLE Brand_To_Name(
  brand VARCHAR(20),
  name VARCHAR(50),
  price INTEGER,
  PRIMARY KEY(brand, name)
);

CREATE TABLE District(
  district VARCHAR(50),
  shipping INTEGER,
  PRIMARY KEY(district)
);

CREATE TABLE Users (
  email VARCHAR(50) NOT NULL,
  nickname VARCHAR(20) NOT NULL,
  first_name VARCHAR(20) NOT NULL,
  last_name VARCHAR(20) NOT NULL,
  password VARCHAR(20) NOT NULL,
  district VARCHAR(50) NOT NULL,
  cell_num VARCHAR(20) NOT NULL,
  balance INTEGER DEFAULT 0,
  gender VARCHAR(20) NOT NULL,
  joindate DATE,
  PRIMARY KEY(email)
);


CREATE TABLE Shoe(
  upload_id VARCHAR(20),
  brand VARCHAR(20),
  shoe_name VARCHAR(50),
  color VARCHAR(20),
  quantity INTEGER,
  sizes INTEGER,
  address VARCHAR(150),
  PRIMARY KEY(upload_id),
  FOREIGN KEY(brand) REFERENCES Brand(brand),
  FOREIGN KEY(sizes) REFERENCES Sizes(sizes)
);


CREATE TABLE Uploads (
  upload_id VARCHAR(20),
  email VARCHAR(50) NOT NULL,
  dates DATE,
  PRIMARY KEY(upload_id),
  FOREIGN KEY(upload_id) REFERENCES Shoe(upload_id) ON DELETE CASCADE,
  FOREIGN KEY(email) REFERENCES Users(email)
);
CREATE TABLE Community (
  article_id INTEGER,
  likes INTEGER,
  views INTEGER,
  title VARCHAR(30),
  content VARCHAR(200),
  email VARCHAR(50) NOT NULL,
  PRIMARY KEY(article_id),
  FOREIGN KEY(email) REFERENCES Users(email)
);
CREATE TABLE Coupon (
  email VARCHAR(50) NOT NULL,
  coupon_id VARCHAR(20),
  amount INTEGER,
  PRIMARY KEY(coupon_id),
  FOREIGN KEY(email) REFERENCES Users(email)
);

CREATE TABLE Writes (
  email VARCHAR(50) NOT NULL,
  article_id INTEGER,
  dates DATE,
  PRIMARY KEY(email,article_id),
  FOREIGN KEY(email) REFERENCES Users(email),
  FOREIGN KEY(article_id) REFERENCES Community(article_id) ON DELETE CASCADE
);

CREATE TABLE Receives (
  email VARCHAR(50) NOT NULL,
  coupon_id VARCHAR(20),
  dates DATE,
  message VARCHAR(30),
  PRIMARY KEY(email, coupon_id),
  FOREIGN KEY(email) REFERENCES Users(email),
  FOREIGN KEY(coupon_id) REFERENCES Coupon(coupon_id) ON DELETE CASCADE
);

CREATE TABLE Buys (
  receipt_num VARCHAR(20) NOT NULL,
  dates DATE,
  email VARCHAR(50) NOT NULL,
  upload_id VARCHAR(20),
  PRIMARY KEY(receipt_num),
  FOREIGN KEY(email) REFERENCES Users(email),
  FOREIGN KEY(upload_id) REFERENCES Shoe(upload_id)
);

CREATE TABLE Comments (
  email VARCHAR(50) NOT NULL,
  upload_id VARCHAR(20),
  dates DATE,
  comment VARCHAR(20),
  PRIMARY KEY(email, upload_id),
  FOREIGN KEY(email) REFERENCES Users(email),
  FOREIGN KEY(upload_id) REFERENCES Shoe(upload_id) ON DELETE CASCADE
);

CREATE TABLE Wishes (
  email VARCHAR(50) NOT NULL,
  upload_id VARCHAR(20),
  dates DATE,
  PRIMARY KEY(email, upload_id),
  FOREIGN KEY(email) REFERENCES Users(email),
  FOREIGN KEY(upload_id) REFERENCES Shoe(upload_id) ON DELETE CASCADE
);

CREATE TABLE Rates (
  email VARCHAR(50) NOT NULL,
  upload_id VARCHAR(20),
  rating INTEGER,
  PRIMARY KEY(email, upload_id),
  FOREIGN KEY(email) REFERENCES Users(email),
  FOREIGN KEY(upload_id) REFERENCES Shoe(upload_id) ON DELETE CASCADE
);

ALTER TABLE Users ADD UNIQUE INDEX (email, cell_num);
ALTER TABLE Community ALTER likes SET DEFAULT 0;
ALTER TABLE Community ALTER views SET DEFAULT 0;

INSERT INTO Users VALUES ('harrykwon97@naver.com', 'harry', 'Hyungtaek', 'Kwon', 'harry1997', 'busan', 01094549819, 1000000, 'male', '2021-05-29');
INSERT INTO Users VALUES ('youngwonchoi@gmail.com', 'yc', 'Youngwon', 'Choi', 'choi1997', 'seoul', 01012345678, 3000000, 'male', '2021-05-27');

INSERT INTO sizes VALUES (230, 'female');
INSERT INTO sizes VALUES (235, 'female');
INSERT INTO sizes VALUES (240, 'female');
INSERT INTO sizes VALUES (245, 'female');
INSERT INTO sizes VALUES (250, 'male');
INSERT INTO sizes VALUES (255, 'male');
INSERT INTO sizes VALUES (260, 'male');
INSERT INTO sizes VALUES (265, 'male');
INSERT INTO sizes VALUES (270, 'male');
INSERT INTO sizes VALUES (275, 'male');
INSERT INTO sizes VALUES (280, 'male');

INSERT INTO Brand VALUES ('nike', 'sports');
INSERT INTO Brand VALUES ('timberland', 'walker');
INSERT INTO Brand VALUES ('salvatore', 'boots');
INSERT INTO Brand VALUES ('dr.martens', 'sandals');
INSERT INTO Brand VALUES ('ysl', 'heels');
INSERT INTO Brand VALUES ('converse', 'sneakers');

INSERT INTO Brand_To_Name VALUES ('nike', 'Pegasus', 1000000);
INSERT INTO Brand_To_Name VALUES ('timberland', 'Walkers', 1234323);
INSERT INTO Brand_To_Name VALUES ('salvatore', 'LVS', 1412342034);
INSERT INTO Brand_To_Name VALUES ('dr.martens', 'SD', 1000000);
INSERT INTO Brand_To_Name VALUES ('ysl', 'SL', 1234323);
INSERT INTO Brand_To_Name VALUES ('converse', 'HIGH', 141230);

INSERT INTO Shoe VALUES ('U1', 'nike', 'pegasus', 'black', 5, 270 , 'im1.jpg');
INSERT INTO Shoe VALUES ('U2', 'timberland', 'Walkers', 'black', 5, 280 , 'im2.jpg');
INSERT INTO Shoe VALUES ('U3', 'salvatore', 'LVS', 'black', 5, 240, 'im3.jpg');
INSERT INTO Shoe VALUES ('U4',  'dr.martens', 'SD', 'black', 5,  260,  'im4.jpg');
INSERT INTO Shoe VALUES ('U5',  'ysl', 'SL', 'black', 5, 230,  'im5.jpg');
INSERT INTO Shoe VALUES ('U6',  'converse', 'HIGH', 'black', 5,  275,  'im6.jpg');

INSERT INTO Uploads VALUES('U1', 'harrykwon97@naver.com', '2021-06-01');
INSERT INTO Uploads VALUES('U2', 'harrykwon97@naver.com', '2021-06-01');
INSERT INTO Uploads VALUES('U3', 'harrykwon97@naver.com',  '2021-06-01');
INSERT INTO Uploads VALUES('U4', 'harrykwon97@naver.com',  '2021-06-01');
INSERT INTO Uploads VALUES('U5', 'harrykwon97@naver.com',  '2021-06-01');
INSERT INTO Uploads VALUES('U6', 'youngwonchoi@gmail.com', '2021-06-01');

INSERT INTO Community VALUES(1, 0, 0, 'Pegasus Comfy', 'what do you think', 'youngwonchoi@gmail.com');

INSERT INTO Writes VALUES ('youngwonchoi@gmail.com', '1', '2021-06-01');

INSERT INTO Buys VALUES ('B1000', '2021-06-01', 'youngwonchoi@gmail.com', 'U1');

INSERT INTO Comments VALUES ('youngwonchoi@gmail.com', 'U1', '2021-06-01', 'Good shoe');

INSERT INTO Wishes VALUES ('youngwonchoi@gmail.com', 'U1', '2021-05-31');

INSERT INTO Rates VALUES ('youngwonchoi@gmail.com', 'U1', 5);
INSERT INTO Rates VALUES ('harrykwon97@naver.com', 'U1', 2);

INSERT INTO district VALUES ('seoul', 1000);
INSERT INTO district VALUES ('busan', 3000);
INSERT INTO district VALUES ('daegu', 3000);
INSERT INTO district VALUES ('daejeon', 2000);
INSERT INTO district VALUES ('incheon', 2000);
INSERT INTO district VALUES ('gwangju', 3000);
INSERT INTO district VALUES ('ulsan', 3000);

CREATE TRIGGER DeleteArticleTrig
  AFTER DELETE ON Community
  FOR EACH ROW
  DELETE FROM Writes WHERE article_id = OLD.article_id;

CREATE TRIGGER CommunityTrig2
  AFTER INSERT ON Community
  FOR EACH ROW
  INSERT INTO Writes(email,article_id,dates) VALUES (NEW.email, NEW.article_id, CURDATE());

delimiter $$
CREATE TRIGGER CouponTrig
  AFTER INSERT ON Coupon
  FOR EACH ROW
  BEGIN
    SELECT NEW.email, NEW.coupon_id, NEW.amount INTO @email, @coupon_id, @amount;
    UPDATE Users SET Users.balance = Users.balance + @amount WHERE @email = Users.email;
    INSERT INTO Receives VALUES (@email, @coupon_id, CURDATE(), 'Congratulations!');
    END; $$
  delimiter ;


delimiter $$
CREATE TRIGGER BuyTrig
  BEFORE INSERT ON Buys
  FOR EACH ROW
  BEGIN
    SELECT NEW.upload_id, NEW.email INTO @upload_id, @buyeremail;
    SELECT price,quantity INTO @shoeprice, @quantity FROM Shoe INNER JOIN Brand_To_Name
      ON Shoe.shoe_name = Brand_To_Name.name WHERE @upload_id = Shoe.upload_id;
    SELECT balance INTO @balance FROM Users WHERE Users.email = @buyeremail;
    SELECT email INTO @selleremail FROM Uploads WHERE Uploads.upload_id = @upload_id;
    SELECT shipping INTO @shippingfee FROM District INNER JOIN Users ON District.district = Users.district WHERE Users.email = @buyeremail;
    IF(@balance >= (@shoeprice+@shippingfee) AND @quantity > 0) THEN
      UPDATE Users SET Users.balance = (Users.balance-@shoeprice)-@shippingfee WHERE Users.email=@buyeremail;
      UPDATE Shoe SET Shoe.quantity = Shoe.quantity- 1 WHERE @upload_id = Shoe.upload_id;
      UPDATE Users SET Users.balance = Users.balance + @shoeprice WHERE Users.email = @selleremail;
    END IF;
    END; $$
  delimiter ;

INSERT INTO Coupon VALUES ('youngwonchoi@gmail.com','C100', 1000);