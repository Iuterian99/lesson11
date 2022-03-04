CREATE TABLE accounts(
account_id bigserial PRIMARY KEY,
account_name varchar(50) NOT NULL,
account_budget DECIMAL(10, 2) NOT NULL
);

INSERT INTO accounts (account_name, account_budget) VALUES ('Shoxrux', 500000);
INSERT INTO accounts (account_name, account_budget) VALUES ('Abduhalim', 100000);

CREATE OR REPLACE PROCEDURE transfer(senderId int, receiverId int, amount int)
LANGUAGE plpgsql
AS
$$
BEGIN
  IF
    (
      (SELECT account_id FROM accounts WHERE account_id = senderId) IS NULL
    OR
      (SELECT account_id FROM accounts WHERE account_id = receiverId ) IS NULL    
    )
  THEN 
    RAISE EXCEPTION 'Sender / Receiver not found☹';
  ELSIF
    ((SELECT account_budget FROM accounts WHERE account_id = senderId ) < amount)
  THEN 
    RAISE EXCEPTION 'You have less budget☹';
  ELSE
    UPDATE accounts SET account_budget = account_budget - amount WHERE account_id = senderId;
    UPDATE accounts SET account_budget = account_budget + amount WHERE account_id = receiverId;
    RAISE INFO 'Money successfully passed to %!', (SELECT account_name FROM accounts WHERE account_id = receiverId );
  END IF;
END;
$$;