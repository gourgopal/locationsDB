USE [XYZ]
GO
/****** Object:  Table [loc].[locations_postal]    Script Date: 01-18-2018 16:16:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [loc].[locations_postal](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[City_ID] [int] NULL,
	[postal_code] [numeric](6, 0) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
