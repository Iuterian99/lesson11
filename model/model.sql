CREATE TABLE accounts(
account_id bigserial PRIMARY KEY,
account_name varchar(50) NOT NULL,
account_budget DECIMAL(10, 2) NOT NULL
);

INSERT INTO accounts (account_name, account_budget) VALUES ('Shoxrux', 500000);
INSERT INTO accounts (account_name, account_budget) VALUES ('Abduhalim', 100000);

CREATE OR REPLACE PROCEDURE 