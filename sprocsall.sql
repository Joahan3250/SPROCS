USE AncEnergy;
IF OBJECT_ID('dbo.A_LIVPropertyAudit', 'P') IS NOT NULL
    DROP PROCEDURE dbo.A_LIVPropertyAudit;
GO

CREATE PROCEDURE dbo.A_LIVPropertyAudit

AS
BEGIN
    -- Código del procedimiento...
select	Organization.OrganizationCode,
		CustomerMaster.AccountNo,
		Premise.PremiseNo, 
		isnull(CustomerMaster.PropertyCustAccountno,'')PropertyCustAccountno,
		unit ,
		(CustomerMaster.FirstName+' '+CustomerMaster.LastName)ANCCustomer ,
		CustomerMovementHistory.MoveInDate,
		CustomerMovementHistory.MoveOutDate,
		A.Tenant,A.UnitId,A.Customer,A.MoveIn,A.Moveout
from Premise 
inner join Organization on Organization.OrganizationId=Premise.OrganizationId
left outer join CustomerMaster on CustomerMaster.PremiseNo=Premise.PremiseNo and CustStatusCode in(1,2) 
left outer join Address on Address.MasterId=Premise.PremiseNo and MasterType=1
left outer join CustomerMovementHistory on CustomerMovementHistory.AccountNo=CustomerMaster.AccountNo 
inner join LIVLeaseListing A on A.UnitId =Address.unit
where Organization.OrganizationId=1530
and  CustomerMaster.PropertyCustAccountno is NULL 
--and CustomerMaster.AccountNo is NUll



	
END -- End of PROCEDURE