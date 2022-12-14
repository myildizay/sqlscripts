USE [TEST]
GO
/****** Object:  StoredProcedure [dbo].[cLoadDatatable]    Script Date: 21.01.2020 12:10:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[cLoadDatatable]
	
as
BEGIN
	SET NOCOUNT ON
    
   
	SELECT * FROM Datatable  

END

GO
/****** Object:  StoredProcedure [dbo].[cLoadMemberLogin]    Script Date: 21.01.2020 12:10:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[cLoadMemberLogin]
	
as
BEGIN
	SET NOCOUNT ON
    
   
	select MemberLoginID, SessionID, MemberID, PageName, LoginDatetime, LogoutDatetime,
(case when LogoutDatetime is null then 0 else  LogoutDatetime - LoginDatetime end) Duration 
 from MemberLogin order by LoginDatetime desc

END

GO
/****** Object:  StoredProcedure [dbo].[cLoadMenuUserGroup]    Script Date: 21.01.2020 12:10:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[cLoadMenuUserGroup]
	
as
BEGIN
	SET NOCOUNT ON
    
   
	SELECT * FROM MenuUserGroup MUG
LEFT JOIN Menu M ON M.MenuID = mug.MenuID
LEFT JOIN UserGroup UG ON UG.UserGroupID = MUG.UserGroupID

END

GO
/****** Object:  StoredProcedure [dbo].[cLoadMenuUserGroupParamByMenuIDUserGroupID]    Script Date: 21.01.2020 12:10:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[cLoadMenuUserGroupParamByMenuIDUserGroupID]
	@UserGroupID int , 
	@MenuID int 
as
BEGIN
	SET NOCOUNT ON
    
   
	SELECT * FROM MenuUserGroup MUG where UserGroupID = @UserGroupID and MenuID = @MenuID


END

GO
/****** Object:  StoredProcedure [dbo].[cSaveDatatable]    Script Date: 21.01.2020 12:10:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[cSaveDatatable]
	@DatatableID int,
	@DatatableName nvarchar(50), 
	@DatatableColumnName nvarchar(50), 
	@DatatableColumnVisibleName nvarchar(50), 
	@IsEditable bit
	
	
	
	
	

AS
BEGIN
	
	IF @DatatableID > 0
		UPDATE
			[Datatable]
		SET
			DatatableColumnVisibleName=@DatatableName
			
		WHERE
			DatatableID = @DatatableID
			
			
	ELSE
	BEGIN
		INSERT INTO
			[dbo].[Datatable]
				(DatatableName, DatatableColumnName, DatatableColumnVisibleName, IsEditable)
				
		VALUES 
			(@DatatableName, @DatatableColumnName, @DatatableColumnVisibleName, @IsEditable)

		
		return @@IDENTITY 
	 
	END
	
	 
END

GO
/****** Object:  StoredProcedure [dbo].[cSaveMemberLogin]    Script Date: 21.01.2020 12:10:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[cSaveMemberLogin]
	@MemberLoginID int,
	@SessionID varchar(255),
	@MemberID int, 
	@PageName nvarchar(50), 
	@LoginDatetime datetime, 
	@LogoutDatetime datetime
	
	
	
	
	

AS
BEGIN
	
	IF @MemberLoginID > 0
		UPDATE
			MemberLogin
		SET
			MemberID= @MemberID , 
			PageName = @PageName , 
			LoginDatetime = @LoginDatetime , 
			LogoutDatetime  = @LogoutDatetime 
		WHERE
			MemberLoginID = @MemberLoginID
			
			
	ELSE
	BEGIN
		INSERT INTO
			MemberLogin
				(SessionID,MemberID, PageName, LoginDatetime, LogoutDatetime)
		VALUES 
			(@SessionID, @MemberID,   @PageName, @LoginDatetime, null)

		
		return @@IDENTITY 
	 
	END
	
	 
END

GO
/****** Object:  StoredProcedure [dbo].[cUpdateMemberLogoutDatetime]    Script Date: 21.01.2020 12:10:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[cUpdateMemberLogoutDatetime]
	@MemberLoginID int,
	@LogoutDatetime datetime
	
	
	
	
	

AS
BEGIN
	
	UPDATE
			MemberLogin
		SET
			LogoutDatetime  = @LogoutDatetime 
		WHERE
			MemberLoginID = @MemberLoginID
	 

	
	 
END

GO
/****** Object:  StoredProcedure [dbo].[cUpdateMemberLogoutDatetimeParamByMemberIDPageName]    Script Date: 21.01.2020 12:10:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[cUpdateMemberLogoutDatetimeParamByMemberIDPageName]
	@MemberLoginID int, 
	@SessionID varchar(255),
	@MemberID int,
	@PageName nvarchar(25),
	@LogoutDatetime datetime
	
	
	
	
	

AS
BEGIN
	
	UPDATE
			MemberLogin
		SET
			LogoutDatetime  = @LogoutDatetime 
		WHERE
			MemberID = @MemberID and PageName = @PageName
			and SessionID = @SessionID
	 

	
	 
END

GO
/****** Object:  StoredProcedure [dbo].[cUpdateMenuUserGroup]    Script Date: 21.01.2020 12:10:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[cUpdateMenuUserGroup]
	@MenuUserGroupID int,
	@Insert bit,
	@Delete bit,
	@Edit bit

	
	
	
	
	

AS
BEGIN
	
	 UPDATE [dbo].[MenuUserGroup]
	 SET 
	[Insert] = @Insert, 
	[Delete] = @Delete, 
	[Edit] = @Edit
	WHERE MenuUserGroupID = @MenuUserGroupID
	 
END

GO
/****** Object:  Table [dbo].[Datatable]    Script Date: 21.01.2020 12:10:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Datatable](
	[DatatableID] [int] IDENTITY(1,1) NOT NULL,
	[DatatableName] [nvarchar](50) NULL,
	[DatatableColumnName] [nvarchar](50) NULL,
	[DatatableColumnVisibleName] [nvarchar](50) NULL,
	[IsEditable] [bit] NULL,
 CONSTRAINT [PK_Datatable] PRIMARY KEY CLUSTERED 
(
	[DatatableID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MemberLogin]    Script Date: 21.01.2020 12:10:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MemberLogin](
	[MemberLoginID] [int] IDENTITY(1,1) NOT NULL,
	[SessionID] [varchar](255) NULL,
	[MemberID] [int] NULL,
	[PageName] [nvarchar](25) NULL,
	[LoginDatetime] [datetime] NULL,
	[LogoutDatetime] [datetime] NULL,
 CONSTRAINT [PK_MemberLogin] PRIMARY KEY CLUSTERED 
(
	[MemberLoginID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Menu]    Script Date: 21.01.2020 12:10:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Menu](
	[MenuID] [int] IDENTITY(1,1) NOT NULL,
	[MenuName] [nvarchar](25) NULL,
 CONSTRAINT [PK_Menu] PRIMARY KEY CLUSTERED 
(
	[MenuID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MenuUserGroup]    Script Date: 21.01.2020 12:10:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MenuUserGroup](
	[MenuUserGroupID] [int] IDENTITY(1,1) NOT NULL,
	[MenuID] [int] NULL,
	[UserGroupID] [int] NULL,
	[Insert] [bit] NULL,
	[Delete] [bit] NULL,
	[Edit] [bit] NULL,
 CONSTRAINT [PK_MemberUserGroup] PRIMARY KEY CLUSTERED 
(
	[MenuUserGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserGroup]    Script Date: 21.01.2020 12:10:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserGroup](
	[UserGroupID] [int] NOT NULL,
	[UserGroupName] [nvarchar](25) NULL,
 CONSTRAINT [PK_UserGroup] PRIMARY KEY CLUSTERED 
(
	[UserGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Datatable] ON 

INSERT [dbo].[Datatable] ([DatatableID], [DatatableName], [DatatableColumnName], [DatatableColumnVisibleName], [IsEditable]) VALUES (1, N'dGrid', N'Şube
', N'Sube', 0)
INSERT [dbo].[Datatable] ([DatatableID], [DatatableName], [DatatableColumnName], [DatatableColumnVisibleName], [IsEditable]) VALUES (2, N'dGrid', N'Kısa SGK No
', N'isyeri_kodu_kisa', 0)
INSERT [dbo].[Datatable] ([DatatableID], [DatatableName], [DatatableColumnName], [DatatableColumnVisibleName], [IsEditable]) VALUES (3, N'dGrid', N'Ünvan
', N'Unvani', 0)
INSERT [dbo].[Datatable] ([DatatableID], [DatatableName], [DatatableColumnName], [DatatableColumnVisibleName], [IsEditable]) VALUES (4, N'dGrid', N'SGK No
', N'isyeri_kodu', 1)
INSERT [dbo].[Datatable] ([DatatableID], [DatatableName], [DatatableColumnName], [DatatableColumnVisibleName], [IsEditable]) VALUES (5, N'dGrid', N'İşletme Unvan
', N'İşletme Unvan', 1)
INSERT [dbo].[Datatable] ([DatatableID], [DatatableName], [DatatableColumnName], [DatatableColumnVisibleName], [IsEditable]) VALUES (6, N'dGrid', N'Açılış Tarihi
', N'Açılış Tarihi', 1)
INSERT [dbo].[Datatable] ([DatatableID], [DatatableName], [DatatableColumnName], [DatatableColumnVisibleName], [IsEditable]) VALUES (7, N'dGrid', N'İl/İlçe
', N'Il_Ilce', 1)
INSERT [dbo].[Datatable] ([DatatableID], [DatatableName], [DatatableColumnName], [DatatableColumnVisibleName], [IsEditable]) VALUES (8, N'dGrid', N'Adres
', N'Adres', 1)
INSERT [dbo].[Datatable] ([DatatableID], [DatatableName], [DatatableColumnName], [DatatableColumnVisibleName], [IsEditable]) VALUES (9, N'dGrid', N'Telefon
', N'', 1)
INSERT [dbo].[Datatable] ([DatatableID], [DatatableName], [DatatableColumnName], [DatatableColumnVisibleName], [IsEditable]) VALUES (10, N'dGrid', N'Kategori
', N'', 1)
INSERT [dbo].[Datatable] ([DatatableID], [DatatableName], [DatatableColumnName], [DatatableColumnVisibleName], [IsEditable]) VALUES (11, N'dGrid', N'Sektör
', N'Sektör', 1)
INSERT [dbo].[Datatable] ([DatatableID], [DatatableName], [DatatableColumnName], [DatatableColumnVisibleName], [IsEditable]) VALUES (12, N'dGrid', N'Örgütlülük
', N'orgutlu', 1)
INSERT [dbo].[Datatable] ([DatatableID], [DatatableName], [DatatableColumnName], [DatatableColumnVisibleName], [IsEditable]) VALUES (13, N'dGrid', N'Avans Günü
', N'Avans Günü', 1)
INSERT [dbo].[Datatable] ([DatatableID], [DatatableName], [DatatableColumnName], [DatatableColumnVisibleName], [IsEditable]) VALUES (14, N'dGrid', N'İşçi Sayısı
', N'Isci', 1)
INSERT [dbo].[Datatable] ([DatatableID], [DatatableName], [DatatableColumnName], [DatatableColumnVisibleName], [IsEditable]) VALUES (15, N'dGrid', N'Çalışan Üye Sayısı
', N'Uye', 1)
INSERT [dbo].[Datatable] ([DatatableID], [DatatableName], [DatatableColumnName], [DatatableColumnVisibleName], [IsEditable]) VALUES (17, N'dGrid', N'Çalışan Erkek Üye', N'Çalışan Erkek Üye', 1)
INSERT [dbo].[Datatable] ([DatatableID], [DatatableName], [DatatableColumnName], [DatatableColumnVisibleName], [IsEditable]) VALUES (18, N'dGrid', N'Çalışan Kadın Üye', N'Çalışan Kadın Üye', 1)
INSERT [dbo].[Datatable] ([DatatableID], [DatatableName], [DatatableColumnName], [DatatableColumnVisibleName], [IsEditable]) VALUES (19, N'dGrid', N'Kapsamiçi Üye Sayısı
', N'Kapsam_ici', 1)
INSERT [dbo].[Datatable] ([DatatableID], [DatatableName], [DatatableColumnName], [DatatableColumnVisibleName], [IsEditable]) VALUES (20, N'dGrid', N'Kapsamdışı Üye Sayısı
', N'Kapsam_disi', 1)
INSERT [dbo].[Datatable] ([DatatableID], [DatatableName], [DatatableColumnName], [DatatableColumnVisibleName], [IsEditable]) VALUES (21, N'dGrid', N'Dayanışma Sayısı
', N'Dayanışma Sayısı', 1)
INSERT [dbo].[Datatable] ([DatatableID], [DatatableName], [DatatableColumnName], [DatatableColumnVisibleName], [IsEditable]) VALUES (22, N'dGrid', N'İşveren Sendikası
', N'İşveren Sendikası', 1)
SET IDENTITY_INSERT [dbo].[Datatable] OFF
SET IDENTITY_INSERT [dbo].[MemberLogin] ON 

INSERT [dbo].[MemberLogin] ([MemberLoginID], [SessionID], [MemberID], [PageName], [LoginDatetime], [LogoutDatetime]) VALUES (1, N'ytx1gyx0un4zr2dxhhtesfcq', 0, N'WebForm2.aspx', CAST(N'2018-08-21 16:56:58.150' AS DateTime), CAST(N'2018-08-21 16:57:29.653' AS DateTime))
INSERT [dbo].[MemberLogin] ([MemberLoginID], [SessionID], [MemberID], [PageName], [LoginDatetime], [LogoutDatetime]) VALUES (2, N'ytx1gyx0un4zr2dxhhtesfcq', 0, N'WebForm4.aspx', CAST(N'2018-08-21 16:57:29.653' AS DateTime), CAST(N'2018-08-21 17:00:58.940' AS DateTime))
INSERT [dbo].[MemberLogin] ([MemberLoginID], [SessionID], [MemberID], [PageName], [LoginDatetime], [LogoutDatetime]) VALUES (3, N'ytx1gyx0un4zr2dxhhtesfcq', 0, N'WebForm5.aspx', CAST(N'2018-08-21 17:00:58.940' AS DateTime), NULL)
INSERT [dbo].[MemberLogin] ([MemberLoginID], [SessionID], [MemberID], [PageName], [LoginDatetime], [LogoutDatetime]) VALUES (4, N'lvb2zobybqnpefgqrrhzjwzp', 0, N'WebForm2.aspx', CAST(N'2018-08-22 17:23:31.967' AS DateTime), CAST(N'2018-08-22 17:23:44.620' AS DateTime))
INSERT [dbo].[MemberLogin] ([MemberLoginID], [SessionID], [MemberID], [PageName], [LoginDatetime], [LogoutDatetime]) VALUES (5, N'lvb2zobybqnpefgqrrhzjwzp', 0, N'WebForm4.aspx', CAST(N'2018-08-22 17:23:44.620' AS DateTime), CAST(N'2018-08-22 17:24:46.177' AS DateTime))
INSERT [dbo].[MemberLogin] ([MemberLoginID], [SessionID], [MemberID], [PageName], [LoginDatetime], [LogoutDatetime]) VALUES (6, N'lvb2zobybqnpefgqrrhzjwzp', 0, N'WebForm5.aspx', CAST(N'2018-08-22 17:24:46.177' AS DateTime), CAST(N'2018-08-22 17:24:59.743' AS DateTime))
INSERT [dbo].[MemberLogin] ([MemberLoginID], [SessionID], [MemberID], [PageName], [LoginDatetime], [LogoutDatetime]) VALUES (7, N'lvb2zobybqnpefgqrrhzjwzp', 0, N'WebForm4.aspx', CAST(N'2018-08-22 17:24:59.743' AS DateTime), NULL)
INSERT [dbo].[MemberLogin] ([MemberLoginID], [SessionID], [MemberID], [PageName], [LoginDatetime], [LogoutDatetime]) VALUES (8, N'hwjrxbnty0fd3fgwkrncdicu', 0, N'MemberLogin.aspx', CAST(N'2018-08-24 17:09:58.077' AS DateTime), CAST(N'2018-08-25 16:27:49.210' AS DateTime))
INSERT [dbo].[MemberLogin] ([MemberLoginID], [SessionID], [MemberID], [PageName], [LoginDatetime], [LogoutDatetime]) VALUES (9, N'hwjrxbnty0fd3fgwkrncdicu', 0, N'MemberLogin.aspx', CAST(N'2018-08-24 17:11:14.517' AS DateTime), CAST(N'2018-08-25 16:27:49.210' AS DateTime))
INSERT [dbo].[MemberLogin] ([MemberLoginID], [SessionID], [MemberID], [PageName], [LoginDatetime], [LogoutDatetime]) VALUES (10, N'hwjrxbnty0fd3fgwkrncdicu', 0, N'MemberLogin.aspx', CAST(N'2018-08-24 17:42:46.150' AS DateTime), CAST(N'2018-08-25 16:27:49.210' AS DateTime))
INSERT [dbo].[MemberLogin] ([MemberLoginID], [SessionID], [MemberID], [PageName], [LoginDatetime], [LogoutDatetime]) VALUES (11, N'hwjrxbnty0fd3fgwkrncdicu', 0, N'MemberLogin.aspx', CAST(N'2018-08-25 16:24:37.087' AS DateTime), CAST(N'2018-08-25 16:27:49.210' AS DateTime))
INSERT [dbo].[MemberLogin] ([MemberLoginID], [SessionID], [MemberID], [PageName], [LoginDatetime], [LogoutDatetime]) VALUES (12, N'hwjrxbnty0fd3fgwkrncdicu', 0, N'MemberLogin.aspx', CAST(N'2018-08-25 16:24:47.730' AS DateTime), CAST(N'2018-08-25 16:27:49.210' AS DateTime))
INSERT [dbo].[MemberLogin] ([MemberLoginID], [SessionID], [MemberID], [PageName], [LoginDatetime], [LogoutDatetime]) VALUES (13, N'hwjrxbnty0fd3fgwkrncdicu', 0, N'WebForm4.aspx', CAST(N'2018-08-25 16:24:56.143' AS DateTime), CAST(N'2018-08-25 16:27:55.593' AS DateTime))
INSERT [dbo].[MemberLogin] ([MemberLoginID], [SessionID], [MemberID], [PageName], [LoginDatetime], [LogoutDatetime]) VALUES (14, N'hwjrxbnty0fd3fgwkrncdicu', 0, N'WebForm4.aspx', CAST(N'2018-08-25 16:25:53.390' AS DateTime), CAST(N'2018-08-25 16:27:55.593' AS DateTime))
INSERT [dbo].[MemberLogin] ([MemberLoginID], [SessionID], [MemberID], [PageName], [LoginDatetime], [LogoutDatetime]) VALUES (15, N'hwjrxbnty0fd3fgwkrncdicu', 0, N'MemberLogin.aspx', CAST(N'2018-08-25 16:26:53.090' AS DateTime), CAST(N'2018-08-25 16:27:49.210' AS DateTime))
INSERT [dbo].[MemberLogin] ([MemberLoginID], [SessionID], [MemberID], [PageName], [LoginDatetime], [LogoutDatetime]) VALUES (16, N'hwjrxbnty0fd3fgwkrncdicu', 0, N'WebForm4.aspx', CAST(N'2018-08-25 16:27:03.503' AS DateTime), CAST(N'2018-08-25 16:27:55.593' AS DateTime))
INSERT [dbo].[MemberLogin] ([MemberLoginID], [SessionID], [MemberID], [PageName], [LoginDatetime], [LogoutDatetime]) VALUES (17, N'hwjrxbnty0fd3fgwkrncdicu', 0, N'MemberLogin.aspx', CAST(N'2018-08-25 16:27:10.153' AS DateTime), CAST(N'2018-08-25 16:27:49.210' AS DateTime))
INSERT [dbo].[MemberLogin] ([MemberLoginID], [SessionID], [MemberID], [PageName], [LoginDatetime], [LogoutDatetime]) VALUES (18, N'hwjrxbnty0fd3fgwkrncdicu', 0, N'WebForm4.aspx', CAST(N'2018-08-25 16:27:49.210' AS DateTime), CAST(N'2018-08-25 16:27:55.593' AS DateTime))
INSERT [dbo].[MemberLogin] ([MemberLoginID], [SessionID], [MemberID], [PageName], [LoginDatetime], [LogoutDatetime]) VALUES (19, N'hwjrxbnty0fd3fgwkrncdicu', 0, N'MemberLogin.aspx', CAST(N'2018-08-25 16:27:55.593' AS DateTime), NULL)
INSERT [dbo].[MemberLogin] ([MemberLoginID], [SessionID], [MemberID], [PageName], [LoginDatetime], [LogoutDatetime]) VALUES (20, N'hwjrxbnty0fd3fgwkrncdicu', 0, N'MemberLogin.aspx', CAST(N'2018-08-25 16:29:46.283' AS DateTime), NULL)
INSERT [dbo].[MemberLogin] ([MemberLoginID], [SessionID], [MemberID], [PageName], [LoginDatetime], [LogoutDatetime]) VALUES (21, N'hwjrxbnty0fd3fgwkrncdicu', 0, N'MemberLogin.aspx', CAST(N'2018-08-25 16:32:15.910' AS DateTime), NULL)
INSERT [dbo].[MemberLogin] ([MemberLoginID], [SessionID], [MemberID], [PageName], [LoginDatetime], [LogoutDatetime]) VALUES (22, N'hwjrxbnty0fd3fgwkrncdicu', 0, N'MemberLogin.aspx', CAST(N'2018-08-25 16:32:37.780' AS DateTime), NULL)
INSERT [dbo].[MemberLogin] ([MemberLoginID], [SessionID], [MemberID], [PageName], [LoginDatetime], [LogoutDatetime]) VALUES (23, N'hwjrxbnty0fd3fgwkrncdicu', 0, N'MemberLogin.aspx', CAST(N'2018-08-25 16:33:02.897' AS DateTime), NULL)
INSERT [dbo].[MemberLogin] ([MemberLoginID], [SessionID], [MemberID], [PageName], [LoginDatetime], [LogoutDatetime]) VALUES (24, N'hwjrxbnty0fd3fgwkrncdicu', 0, N'MemberLogin.aspx', CAST(N'2018-08-25 16:34:10.607' AS DateTime), NULL)
INSERT [dbo].[MemberLogin] ([MemberLoginID], [SessionID], [MemberID], [PageName], [LoginDatetime], [LogoutDatetime]) VALUES (25, N'fq550yahsyinkkytspi5xby1', 0, N'WebForm.aspx', CAST(N'2019-07-15 14:24:42.530' AS DateTime), NULL)
INSERT [dbo].[MemberLogin] ([MemberLoginID], [SessionID], [MemberID], [PageName], [LoginDatetime], [LogoutDatetime]) VALUES (26, N'wauhj3i3grskhvy02cdy02zf', 0, N'WebForm.aspx', CAST(N'2019-07-15 14:25:44.893' AS DateTime), NULL)
INSERT [dbo].[MemberLogin] ([MemberLoginID], [SessionID], [MemberID], [PageName], [LoginDatetime], [LogoutDatetime]) VALUES (27, N'0mrvq0vguudl0iy1i3be4rtl', 0, N'Calendar.aspx', CAST(N'2019-07-25 11:00:07.190' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[MemberLogin] OFF
SET IDENTITY_INSERT [dbo].[Menu] ON 

INSERT [dbo].[Menu] ([MenuID], [MenuName]) VALUES (1, N'Menu 1 ')
INSERT [dbo].[Menu] ([MenuID], [MenuName]) VALUES (2, N'Menu 2')
INSERT [dbo].[Menu] ([MenuID], [MenuName]) VALUES (3, N'Menu 3')
INSERT [dbo].[Menu] ([MenuID], [MenuName]) VALUES (4, N'Menu 4')
INSERT [dbo].[Menu] ([MenuID], [MenuName]) VALUES (5, N'Menu 5')
INSERT [dbo].[Menu] ([MenuID], [MenuName]) VALUES (6, N'Menu 6')
INSERT [dbo].[Menu] ([MenuID], [MenuName]) VALUES (7, N'Menu 7')
INSERT [dbo].[Menu] ([MenuID], [MenuName]) VALUES (8, N'Menu 8')
INSERT [dbo].[Menu] ([MenuID], [MenuName]) VALUES (9, N'Menu 9')
INSERT [dbo].[Menu] ([MenuID], [MenuName]) VALUES (10, N'Menu 10')
SET IDENTITY_INSERT [dbo].[Menu] OFF
SET IDENTITY_INSERT [dbo].[MenuUserGroup] ON 

INSERT [dbo].[MenuUserGroup] ([MenuUserGroupID], [MenuID], [UserGroupID], [Insert], [Delete], [Edit]) VALUES (1, 1, 1, 1, 0, 0)
INSERT [dbo].[MenuUserGroup] ([MenuUserGroupID], [MenuID], [UserGroupID], [Insert], [Delete], [Edit]) VALUES (2, 1, 2, 0, 0, 0)
INSERT [dbo].[MenuUserGroup] ([MenuUserGroupID], [MenuID], [UserGroupID], [Insert], [Delete], [Edit]) VALUES (3, 1, 3, 0, 0, 0)
INSERT [dbo].[MenuUserGroup] ([MenuUserGroupID], [MenuID], [UserGroupID], [Insert], [Delete], [Edit]) VALUES (4, 1, 4, 1, 0, 0)
INSERT [dbo].[MenuUserGroup] ([MenuUserGroupID], [MenuID], [UserGroupID], [Insert], [Delete], [Edit]) VALUES (5, 1, 5, 0, 0, 0)
INSERT [dbo].[MenuUserGroup] ([MenuUserGroupID], [MenuID], [UserGroupID], [Insert], [Delete], [Edit]) VALUES (6, 2, 1, 0, 0, 1)
INSERT [dbo].[MenuUserGroup] ([MenuUserGroupID], [MenuID], [UserGroupID], [Insert], [Delete], [Edit]) VALUES (7, 2, 2, 0, 0, 1)
INSERT [dbo].[MenuUserGroup] ([MenuUserGroupID], [MenuID], [UserGroupID], [Insert], [Delete], [Edit]) VALUES (8, 2, 3, 0, 0, 1)
INSERT [dbo].[MenuUserGroup] ([MenuUserGroupID], [MenuID], [UserGroupID], [Insert], [Delete], [Edit]) VALUES (9, 2, 4, 0, 0, 1)
INSERT [dbo].[MenuUserGroup] ([MenuUserGroupID], [MenuID], [UserGroupID], [Insert], [Delete], [Edit]) VALUES (10, 2, 5, 1, 1, 0)
INSERT [dbo].[MenuUserGroup] ([MenuUserGroupID], [MenuID], [UserGroupID], [Insert], [Delete], [Edit]) VALUES (11, 3, 1, 1, 1, 0)
INSERT [dbo].[MenuUserGroup] ([MenuUserGroupID], [MenuID], [UserGroupID], [Insert], [Delete], [Edit]) VALUES (12, 3, 2, 1, 1, 0)
INSERT [dbo].[MenuUserGroup] ([MenuUserGroupID], [MenuID], [UserGroupID], [Insert], [Delete], [Edit]) VALUES (13, 3, 3, 1, 0, 0)
INSERT [dbo].[MenuUserGroup] ([MenuUserGroupID], [MenuID], [UserGroupID], [Insert], [Delete], [Edit]) VALUES (14, 3, 4, 1, 0, 0)
INSERT [dbo].[MenuUserGroup] ([MenuUserGroupID], [MenuID], [UserGroupID], [Insert], [Delete], [Edit]) VALUES (15, 3, 5, 0, 0, 1)
INSERT [dbo].[MenuUserGroup] ([MenuUserGroupID], [MenuID], [UserGroupID], [Insert], [Delete], [Edit]) VALUES (16, 4, 1, 0, 0, 1)
INSERT [dbo].[MenuUserGroup] ([MenuUserGroupID], [MenuID], [UserGroupID], [Insert], [Delete], [Edit]) VALUES (17, 4, 2, 0, 0, 0)
INSERT [dbo].[MenuUserGroup] ([MenuUserGroupID], [MenuID], [UserGroupID], [Insert], [Delete], [Edit]) VALUES (18, 4, 3, 0, 1, 0)
INSERT [dbo].[MenuUserGroup] ([MenuUserGroupID], [MenuID], [UserGroupID], [Insert], [Delete], [Edit]) VALUES (19, 4, 4, 0, 1, 0)
INSERT [dbo].[MenuUserGroup] ([MenuUserGroupID], [MenuID], [UserGroupID], [Insert], [Delete], [Edit]) VALUES (20, 4, 5, 0, 0, 0)
INSERT [dbo].[MenuUserGroup] ([MenuUserGroupID], [MenuID], [UserGroupID], [Insert], [Delete], [Edit]) VALUES (21, 5, 1, 0, 0, 0)
INSERT [dbo].[MenuUserGroup] ([MenuUserGroupID], [MenuID], [UserGroupID], [Insert], [Delete], [Edit]) VALUES (22, 5, 2, 1, 0, 0)
INSERT [dbo].[MenuUserGroup] ([MenuUserGroupID], [MenuID], [UserGroupID], [Insert], [Delete], [Edit]) VALUES (23, 5, 3, 1, 0, 0)
INSERT [dbo].[MenuUserGroup] ([MenuUserGroupID], [MenuID], [UserGroupID], [Insert], [Delete], [Edit]) VALUES (24, 5, 4, 0, 0, 0)
INSERT [dbo].[MenuUserGroup] ([MenuUserGroupID], [MenuID], [UserGroupID], [Insert], [Delete], [Edit]) VALUES (25, 5, 5, 1, 0, 0)
INSERT [dbo].[MenuUserGroup] ([MenuUserGroupID], [MenuID], [UserGroupID], [Insert], [Delete], [Edit]) VALUES (26, 6, 1, 1, 0, 0)
INSERT [dbo].[MenuUserGroup] ([MenuUserGroupID], [MenuID], [UserGroupID], [Insert], [Delete], [Edit]) VALUES (27, 6, 2, 0, 0, 0)
INSERT [dbo].[MenuUserGroup] ([MenuUserGroupID], [MenuID], [UserGroupID], [Insert], [Delete], [Edit]) VALUES (28, 6, 3, 0, 0, 0)
INSERT [dbo].[MenuUserGroup] ([MenuUserGroupID], [MenuID], [UserGroupID], [Insert], [Delete], [Edit]) VALUES (29, 6, 4, 1, 0, 0)
INSERT [dbo].[MenuUserGroup] ([MenuUserGroupID], [MenuID], [UserGroupID], [Insert], [Delete], [Edit]) VALUES (30, 6, 5, 1, 0, 0)
INSERT [dbo].[MenuUserGroup] ([MenuUserGroupID], [MenuID], [UserGroupID], [Insert], [Delete], [Edit]) VALUES (31, 7, 1, 1, 0, 0)
INSERT [dbo].[MenuUserGroup] ([MenuUserGroupID], [MenuID], [UserGroupID], [Insert], [Delete], [Edit]) VALUES (32, 7, 2, 0, 0, 0)
INSERT [dbo].[MenuUserGroup] ([MenuUserGroupID], [MenuID], [UserGroupID], [Insert], [Delete], [Edit]) VALUES (33, 7, 3, 1, 0, 0)
INSERT [dbo].[MenuUserGroup] ([MenuUserGroupID], [MenuID], [UserGroupID], [Insert], [Delete], [Edit]) VALUES (34, 7, 4, 1, 0, 0)
INSERT [dbo].[MenuUserGroup] ([MenuUserGroupID], [MenuID], [UserGroupID], [Insert], [Delete], [Edit]) VALUES (35, 7, 5, 1, 1, 0)
INSERT [dbo].[MenuUserGroup] ([MenuUserGroupID], [MenuID], [UserGroupID], [Insert], [Delete], [Edit]) VALUES (36, 8, 1, 0, 0, 1)
INSERT [dbo].[MenuUserGroup] ([MenuUserGroupID], [MenuID], [UserGroupID], [Insert], [Delete], [Edit]) VALUES (37, 8, 2, 0, 1, 0)
INSERT [dbo].[MenuUserGroup] ([MenuUserGroupID], [MenuID], [UserGroupID], [Insert], [Delete], [Edit]) VALUES (38, 8, 3, 1, 0, 0)
INSERT [dbo].[MenuUserGroup] ([MenuUserGroupID], [MenuID], [UserGroupID], [Insert], [Delete], [Edit]) VALUES (39, 8, 4, 0, 0, 1)
INSERT [dbo].[MenuUserGroup] ([MenuUserGroupID], [MenuID], [UserGroupID], [Insert], [Delete], [Edit]) VALUES (40, 8, 5, 1, 0, 0)
INSERT [dbo].[MenuUserGroup] ([MenuUserGroupID], [MenuID], [UserGroupID], [Insert], [Delete], [Edit]) VALUES (41, 9, 1, 1, 0, 0)
INSERT [dbo].[MenuUserGroup] ([MenuUserGroupID], [MenuID], [UserGroupID], [Insert], [Delete], [Edit]) VALUES (42, 9, 2, 1, 0, 0)
INSERT [dbo].[MenuUserGroup] ([MenuUserGroupID], [MenuID], [UserGroupID], [Insert], [Delete], [Edit]) VALUES (43, 9, 3, 1, 1, 0)
INSERT [dbo].[MenuUserGroup] ([MenuUserGroupID], [MenuID], [UserGroupID], [Insert], [Delete], [Edit]) VALUES (44, 9, 4, 0, 0, 1)
INSERT [dbo].[MenuUserGroup] ([MenuUserGroupID], [MenuID], [UserGroupID], [Insert], [Delete], [Edit]) VALUES (45, 9, 5, 1, 0, 0)
INSERT [dbo].[MenuUserGroup] ([MenuUserGroupID], [MenuID], [UserGroupID], [Insert], [Delete], [Edit]) VALUES (46, 10, 1, 1, 0, 0)
INSERT [dbo].[MenuUserGroup] ([MenuUserGroupID], [MenuID], [UserGroupID], [Insert], [Delete], [Edit]) VALUES (47, 10, 2, 1, 1, 0)
INSERT [dbo].[MenuUserGroup] ([MenuUserGroupID], [MenuID], [UserGroupID], [Insert], [Delete], [Edit]) VALUES (48, 10, 3, 0, 0, 0)
INSERT [dbo].[MenuUserGroup] ([MenuUserGroupID], [MenuID], [UserGroupID], [Insert], [Delete], [Edit]) VALUES (49, 10, 4, 1, 0, 0)
INSERT [dbo].[MenuUserGroup] ([MenuUserGroupID], [MenuID], [UserGroupID], [Insert], [Delete], [Edit]) VALUES (50, 10, 5, 1, 0, 0)
SET IDENTITY_INSERT [dbo].[MenuUserGroup] OFF
INSERT [dbo].[UserGroup] ([UserGroupID], [UserGroupName]) VALUES (1, N'Admin')
INSERT [dbo].[UserGroup] ([UserGroupID], [UserGroupName]) VALUES (2, N'Power User')
INSERT [dbo].[UserGroup] ([UserGroupID], [UserGroupName]) VALUES (3, N'User')
INSERT [dbo].[UserGroup] ([UserGroupID], [UserGroupName]) VALUES (4, N'Default User')
INSERT [dbo].[UserGroup] ([UserGroupID], [UserGroupName]) VALUES (5, N'Other User')
ALTER TABLE [dbo].[Datatable] ADD  CONSTRAINT [DF_Datatable_IsEditable]  DEFAULT ((0)) FOR [IsEditable]
GO
ALTER TABLE [dbo].[MenuUserGroup] ADD  CONSTRAINT [DF_MemberUserGroup_Insert]  DEFAULT ((1)) FOR [Insert]
GO
ALTER TABLE [dbo].[MenuUserGroup] ADD  CONSTRAINT [DF_MemberUserGroup_Delete]  DEFAULT ((1)) FOR [Delete]
GO
ALTER TABLE [dbo].[MenuUserGroup] ADD  CONSTRAINT [DF_MemberUserGroup_Edit]  DEFAULT ((1)) FOR [Edit]
GO
