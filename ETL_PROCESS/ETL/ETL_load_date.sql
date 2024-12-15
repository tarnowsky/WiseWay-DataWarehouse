use Warehouse
go

-- Fill [DATE]s Lookup Table
-- Step a: Declare variables use in processing
Declare @StartDate date; 
Declare @EndDate date;

-- Step b:  Fill the variable with values for the range of years needed
SELECT @StartDate = '2000-01-01', @EndDate = '2020-12-12';

-- Step c:  Use a while loop to add dates to the table
Declare @DateInProcess datetime = @StartDate;

While @DateInProcess <= @EndDate
	Begin
	--Add a row into the date dimension table for this date
		Insert Into [dbo].[DATE] 
		( [Date]
		, [Year]
		, [Month]
		, [MonthNo]
		, [DayOfWeek]
		, [DayOfWeekNo]
		, [WorkingDay]
		, [Vacation]
		, [Holiday]
		, [BeforeHolidayDay]
		)
		Values ( 
		  @DateInProcess -- [Date]
		  , Cast( Year(@DateInProcess) as varchar(4)) -- [Year]
		  , Cast( DATENAME(month, @DateInProcess) as varchar(10)) -- [Month]
		  , Cast( Month(@DateInProcess) as int) -- [MonthNo]
		  , Cast( DATENAME(dw,@DateInProcess) as varchar(15)) -- [DayOfWeek]
		  , Cast( DATEPART(dw, @DateInProcess) as int) -- [DayOfWeekNo]
		  , CASE
				WHEN DATEPART(dw, @DateInProcess) = 1 THEN 'day off'
				ELSE 'working day'
			END
		  , 'non-vacation' -- will be put in te next steps
		  , 'non-holiday'  -- will be put in te next steps
		  , 'non-holiday day tomorrow'  -- will be put in te next steps
		);  
		-- Add a day and loop again
		Set @DateInProcess = DateAdd(d, 1, @DateInProcess);
	End
go


-- insert into holidays and vacations
-------------------------------------------------------------

-- auxiliary tables should be created first!


If (object_id('vETLDATEsData') is not null) Drop View vETLDATEsData;
go

CREATE VIEW vETLDATEsData
AS
SELECT 
	dd.ID_Date
	, dd.Date
	, dd.Year
	, dd.Month,
	dd.MonthNo
	, dd.DayOfWeek
	, dd.DayOfWeekNo
	, CASE	
		WHEN ah1.wolne = 1 THEN 'day off'
		WHEN dd.WorkingDay = 'day off' THEN 'day off'
		ELSE 'working day'
	  END AS [WorkingDay]
	, CASE
		WHEN w.rodzaj is not null THEN w.rodzaj
		ELSE 'no vacation'
	END AS [Vacation]
	, CASE	
		WHEN ah1.swieto is not null THEN ah1.swieto
		ELSE 'non-holiday'
	  END AS [Holiday]
	, CASE 
		WHEN ah2.BeforeHolidayDay is not null THEN ah2.BeforeHolidayDay
		ELSE 'Brak'
	  END AS [BeforeHolidayDay]

FROM auxiliary.dbo.swieta ah1
right JOIN [DATE] as dd ON dd.Date = ah1.data
left JOIN (SELECT DATEADD("dd", -1, data) as d, 'Jutro ' + swieto as BeforeHolidayDay FROM auxiliary.dbo.swieta) as ah2 ON dd.Date = ah2.d
left JOIN auxiliary.dbo.wakacje as w ON dd.Date BETWEEN w.start AND w.koniec;
go

-- Merge view with updated information about holidays and before holiday days with already existing [DATE] rows

MERGE INTO [DATE] as TT
	USING vETLDatesData as ST
		ON TT.date = ST.date
			WHEN Matched -- when dates match...
			THEN -- update WorkingDay, Holiday and BeforeHolidayDay columns
				UPDATE
				SET TT.WorkingDay = ST.WorkingDay,
					TT.Vacation = ST.Vacation,
					TT.Holiday = ST.Holiday,
					TT.BeforeHolidayDay = ST.BeforeHolidayDay
			;

-- SELECT * from [DATE];

Drop View vETLDATEsData;