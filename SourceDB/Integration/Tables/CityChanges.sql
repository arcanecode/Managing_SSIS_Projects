CREATE TABLE [Integration].[CityChanges](
	[WWI City ID]                [int]          NULL
, [City]                       [nvarchar](50) NULL
, [State Province]             [nvarchar](50) NULL
,	[Country]                    [nvarchar](50) NULL
,	[Continent]                  [nvarchar](30) NULL
,	[Sales Territory]            [nvarchar](50) NULL
,	[Region]                     [nvarchar](30) NULL
,	[Subregion]                  [nvarchar](30) NULL
,	[geography]                  [geography]    NULL
,	[Latest Recorded Population] [bigint]       NULL
,	[Valid From]                 [datetime2](7) NULL
,	[Valid To]                   [datetime2](7) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
