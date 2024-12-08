USE carSharingDW

GO

IF (OBJECT_ID('vETLUsers', 'V') IS NOT NULL) DROP VIEW vETLUsers;
GO
CREATE VIEW vETLUsers
AS
SELECT
	id,
	first_name,
	last_name,
	email
FROM carSharingDB.dbo.users;

GO



MERGE INTO [user] as TT
	USING vETLUsers as ST
	ON TT.[user_id] = ST.id
		WHEN NOT MATCHED
			THEN
				INSERT ([user_id], first_name, last_name, email) 
				VALUES (ST.id, ST.first_name, ST.last_name, ST.email);



DROP VIEW vETLUsers;