
DROP INDEX Production.WorkOrder.IX_WorkOrder_ProductID;

-- Cache
DBCC FREEPROCCACHE; 
DBCC DROPCLEANBUFFERS;


-- #5
CREATE NONCLUSTERED INDEX AAAAAAAAA_productID on Production.WorkOrder(ProductID)
SELECT * FROM Production.WorkOrder WHERE ProductID = 757

DROP INDEX Production.WorkOrder.AAAAAAAAA_productID;

-- #6.1
CREATE NONCLUSTERED INDEX IDX_ProductID_StartDate ON Production.WorkOrder (ProductID) INCLUDE (StartDate);
SELECT WorkOrderID, StartDate FROM Production.WorkOrder 
WHERE ProductID = 757



-- #6.2

SELECT WorkOrderID, StartDate FROM Production.WorkOrder WHERE ProductID = 945

-- #6.3
SELECT WorkOrderID FROM Production.WorkOrder WHERE ProductID = 945 AND StartDate = '2011-12-04'

DROP INDEX Production.WorkOrder.IDX_ProductID_StartDate;

-- #7
CREATE NONCLUSTERED INDEX IDX_ProductID ON Production.WorkOrder (ProductID);
CREATE NONCLUSTERED INDEX IDX_StartDate ON Production.WorkOrder (StartDate);

SELECT WorkOrderID, StartDate FROM Production.WorkOrder WHERE ProductID = 945 AND StartDate = '2011-12-04'

DROP INDEX Production.WorkOrder.IDX_ProductID;
DROP INDEX Production.WorkOrder.IDX_StartDate;

-- #8
CREATE NONCLUSTERED INDEX IDX_Composite_ProductID_StartDate ON Production.WorkOrder (ProductID, StartDate);
SELECT WorkOrderID, StartDate FROM Production.WorkOrder WHERE ProductID = 945 AND StartDate = '2011-12-04'
