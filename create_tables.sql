USE [MyDatabase]
GO

/****** Object:  Table [dbo].[solar_data]    Script Date: 16/05/2022 11:26:02 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[solar_data](
	[event] [nvarchar](14) NULL,
	[solar_level] [nchar](10) NULL,
	[battery_level] [nchar](10) NULL,
	[battery_load] [nchar](10) NULL,
	[battery_state] [nchar](16) NULL,
	[grid_level] [nchar](10) NULL,
	[load_level] [nchar](10) NULL,
	[charge_window] [nchar](10) NULL
) ON [PRIMARY]
GO


