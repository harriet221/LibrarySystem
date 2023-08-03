CREATE TABLE book (
  call_num CHAR(8) PRIMARY KEY,
  title VARCHAR(45) NOT NULL,
  author VARCHAR(45) NOT NULL,
  publisher VARCHAR(20) NOT NULL,
  on_loan CHAR(1) DEFAULT 'X' NOT NULL CHECK(on_loan IN ('O', 'X'))
);

CREATE TABLE members (
    m_id VARCHAR(10) PRIMARY KEY,
    m_name VARCHAR(10) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    status CHAR(1) DEFAULT 'Y' NOT NULL CHECK(status IN ('Y', 'N')),
    cur_loan SMALLINT DEFAULT 0 NOT NULL CHECK(cur_loan BETWEEN 0 AND 5),
    pos_loan SMALLINT GENERATED ALWAYS AS (5 - cur_loan) VIRTUAL
);

CREATE TABLE loan (
    loan_num VARCHAR(20) PRIMARY KEY,
    loan_dates DATE NOT NULL,
    due_dates DATE GENERATED ALWAYS AS (loan_dates + 7) VIRTUAL,
    loan_user VARCHAR(10),
    FOREIGN KEY (loan_user) REFERENCES members (m_id),
    loan_book CHAR(8),
    FOREIGN KEY (loan_book) REFERENCES book (call_num)
);

COMMIT;

-- book table data
INSERT INTO book(call_num, title, author, publisher) 
 VALUES ('843s69g', 'The Goose Girl', 'Shanon Hale', 'bloomsgury');
INSERT INTO book(call_num, title, author, publisher) 
 VALUES ('164w77t', 'Tractatus', 'Wittgenstein', 'bookpin');
INSERT INTO book(call_num, title, author, publisher) 
 VALUES ('843d69s', 'Sherlock Holmes', 'Arthur Conan Doyle', 'penguin books');
INSERT INTO book(call_num, title, author, publisher) 
 VALUES ('005w82c', 'The coding book', 'wecan coding', 'loadfriend');
INSERT INTO book(call_num, title, author, publisher, on_loan) 
 VALUES ('327k58p', 'Python challenge', 'kim something', 'loadfriend', 'O');

-- member table data
ALTER TABLE members MODIFY m_name VARCHAR(20);

INSERT INTO members(m_id, m_name, phone)
 VALUES ('harrpott', 'harry potter', '02-62442');
INSERT INTO members(m_id, m_name, phone) 
 VALUES ('ourhope', 'j hope', '02-0613-0218');
INSERT INTO members(m_id, m_name, phone) 
 VALUES ('rm12', 'rap monster', '02-0613-0912');
INSERT INTO members(m_id, m_name, phone, cur_loan) 
 VALUES ('youjunhyuk', 'kim dokja', '02-0803-1863', 1);
INSERT INTO members(m_id, m_name, phone, status) 
 VALUES ('drwho', 'the doctor', '02-0001-1110', 'N');

-- loan table data
CREATE SEQUENCE loan_seq;

INSERT INTO loan(loan_num, loan_dates, loan_user, loan_book)
VALUES (loan_seq.nextval, '2005-12-25', 'drwho', '327k58p');

DELETE loan WHERE loan_num=1;

ALTER TABLE loan MODIFY loan_num INT;
INSERT INTO loan(loan_num, loan_dates, loan_user, loan_book) 
 VALUES (loan_seq.nextval, '2005-12-25', 'drwho', '327k58p');
 
COMMIT;
