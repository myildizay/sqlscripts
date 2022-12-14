USE [ANALYZE]
GO
/****** Object:  StoredProcedure [dbo].[_cLoadSoftSkillsParamByCompanyID]    Script Date: 23.01.2020 14:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[_cLoadSoftSkillsParamByCompanyID]
@CompanyID int 
	
AS
BEGIN
	
	SELECT * FROM SoftSkill SS 
	LEFT JOIN Company C (NOLOCK) ON  C.CompanyID = SS.CompanyID 
	  WHERE SS.CompanyID = (CASE @CompanyID WHEN 0 THEN SS.CompanyID ELSE @CompanyID END)
	AND SS.SoftSkillIsActive =1 
	AND C.CompanyIsActive =1 
	 
	
	 
END

GO
/****** Object:  StoredProcedure [dbo].[_cSaveMember]    Script Date: 23.01.2020 14:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[_cSaveMember]
	@MemberID int, 
	@MemberName nvarchar(50), 
	@MemberSurname nvarchar(50), 
	@MemberEMail nvarchar(50), 
	@MemberPhone nvarchar(25), 
	@MemberPassword nvarchar(255), 
	@MemberGenderID char(1)
AS
BEGIN
	
	IF @MemberID > 0
	BEGIN
		UPDATE
			 Member
		SET
				 MemberName=@MemberName, 
				 MemberSurname=@MemberSurname,
				 MemberEMail=@MemberEMail, 
				 MemberPhone=@MemberPhone,
				 MemberPassword=@MemberPassword,
				 MemberGenderID =@MemberGenderID  
		WHERE
			MemberID = @MemberID
			
			return @MemberID;
	END	
	ELSE
	BEGIN
		
		INSERT INTO
			Member
			(MemberName, MemberSurname, MemberEMail, MemberPhone, MemberPassword, MemberGenderID, MemberEntranceDate)
		VALUES 
			(@MemberName, @MemberSurname, @MemberEMail, @MemberPhone, @MemberPassword, @MemberGenderID, getdate())

		return @@IDENTITY
		
	 
	END
	
	 
END

GO
/****** Object:  StoredProcedure [dbo].[cDeleteCompany]    Script Date: 23.01.2020 14:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[cDeleteCompany]
	@CompanyID int
	
AS
BEGIN
	
	UPDATE Company SET CompanyIsActive =0 WHERE CompanyID=@CompanyID
	
	 
END

GO
/****** Object:  StoredProcedure [dbo].[cDeleteContent]    Script Date: 23.01.2020 14:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[cDeleteContent]
	@ContentID int
	
AS
BEGIN
	
	UPDATE Content SET ContentIsActive  =0 WHERE ContentID=@ContentID
	
	 
END

GO
/****** Object:  StoredProcedure [dbo].[cDeleteContentCategory]    Script Date: 23.01.2020 14:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[cDeleteContentCategory]
	@ContentCategoryID int
	
AS
BEGIN
	
	UPDATE ContentCategory SET ContentCategoryIsActive  =0 WHERE ContentCategoryID=@ContentCategoryID
	
	 
END

GO
/****** Object:  StoredProcedure [dbo].[cDeleteDepartment]    Script Date: 23.01.2020 14:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[cDeleteDepartment]
	@DepartmentID int
	
AS
BEGIN
	
	UPDATE Department SET DepartmentIsActive =0 WHERE DepartmentID=@DepartmentID
	
	 
END

GO
/****** Object:  StoredProcedure [dbo].[cDeleteGallery]    Script Date: 23.01.2020 14:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[cDeleteGallery]
	@GalleryID int 
	
AS
BEGIN
	
	UPDATE Gallery SET GalleryIsActive  =0 WHERE GalleryID=@GalleryID
	
	 
END

GO
/****** Object:  StoredProcedure [dbo].[cDeleteMember]    Script Date: 23.01.2020 14:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[cDeleteMember]
	@MemberID int
	
AS
BEGIN
	
	UPDATE Member SET MemberIsActive  =0 WHERE MemberID=@MemberID
	
	 
END

GO
/****** Object:  StoredProcedure [dbo].[cDeleteSampleContent]    Script Date: 23.01.2020 14:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[cDeleteSampleContent]
	@SampleContentID int
	
AS
BEGIN
	
	UPDATE SampleContent SET SampleContentIsActive  =0 WHERE SampleContentID=@SampleContentID
	
	 
END

GO
/****** Object:  StoredProcedure [dbo].[cDeleteSoftSkill]    Script Date: 23.01.2020 14:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[cDeleteSoftSkill]
	@SoftSkillID int
	
AS
BEGIN
	
	UPDATE SoftSkill SET SoftSkillIsActive  =0 WHERE SoftSkillID=@SoftSkillID
	
	 
END

GO
/****** Object:  StoredProcedure [dbo].[cLoadCompany]    Script Date: 23.01.2020 14:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[cLoadCompany]
	
AS
BEGIN
	
	SELECT * FROM Company  WHERE CompanyIsActive=1
	
	
	 
END

GO
/****** Object:  StoredProcedure [dbo].[cLoadCompanyParamByCompanyID]    Script Date: 23.01.2020 14:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[cLoadCompanyParamByCompanyID]
	@CompanyID int 
AS
BEGIN
	
	SELECT * FROM Company  WHERE CompanyID=@CompanyID
	
	
	 
END

GO
/****** Object:  StoredProcedure [dbo].[cLoadContent]    Script Date: 23.01.2020 14:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[cLoadContent]
	
AS
BEGIN
	
	SELECT * FROM Content C
	LEFT JOIN ContentCategory CC (NOLOCK) ON CC.ContentCategoryID = C.ContentCategoryID
	where C.ContentIsActive=1 AND CC.ContentCategoryIsActive =1  order by ContentID DESC  
	
	
	 
END

GO
/****** Object:  StoredProcedure [dbo].[cLoadContentCategory]    Script Date: 23.01.2020 14:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE  [dbo].[cLoadContentCategory]
	
AS
BEGIN
	
	
	SET NOCOUNT ON;

    
	SELECT * FROM ContentCategory CC 
	LEFT JOIN MainContentCategory MCC ON MCC.MainContentCategoryID = CC.MainContentCategoryID
	WHERE CC.ContentCategoryIsActive =1 
END

GO
/****** Object:  StoredProcedure [dbo].[cLoadContentCategoryParamByContentCategoryID]    Script Date: 23.01.2020 14:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE  [dbo].[cLoadContentCategoryParamByContentCategoryID]
	@ContentCategoryID int 
AS
BEGIN
	
	
	SET NOCOUNT ON;

    
	SELECT * FROM ContentCategory WHERE ContentCategoryID  = (CASE @ContentCategoryID WHEN 0 THEN ContentCategoryID ELSE @ContentCategoryID END)
END

GO
/****** Object:  StoredProcedure [dbo].[cLoadContentCategoryParamByMainContentCategoryID]    Script Date: 23.01.2020 14:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE  [dbo].[cLoadContentCategoryParamByMainContentCategoryID]
	@MainContentCategoryID int 
AS
BEGIN
	
	
	SET NOCOUNT ON;

    
	SELECT * FROM ContentCategory WHERE MainContentCategoryID =(CASE  @MainContentCategoryID WHEN 0 THEN MainContentCategoryID ELSE @MainContentCategoryID END)
END

GO
/****** Object:  StoredProcedure [dbo].[cLoadContentParamByContentCategoryID]    Script Date: 23.01.2020 14:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE  [dbo].[cLoadContentParamByContentCategoryID]
	@ContentCategoryID int 
AS
BEGIN
	
	
	SET NOCOUNT ON;

    
	SELECT * FROM Content C
	LEFT JOIN ContentCategory CC  ON CC.ContentCategoryID = C.ContentCategoryID 
	LEFT JOIN Language L ON L.LanguageID  = C.ContentLanguageID
	LEFT JOIN Company CO ON CO.CompanyID =C.ContentCompanyID 
	 WHERE CC.ContentCategoryID  = (CASE @ContentCategoryID WHEN 0 THEN CC.ContentCategoryID ELSE @ContentCategoryID END)
	 AND CC.ContentCategoryIsActive =1 
	
END



GO
/****** Object:  StoredProcedure [dbo].[cLoadContentParamByContentCategoryIDIsDraft]    Script Date: 23.01.2020 14:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE  [dbo].[cLoadContentParamByContentCategoryIDIsDraft]
	@ContentCategoryID int ,
	@IsDraft bit  
AS
BEGIN
	
	
	SET NOCOUNT ON;

    
	SELECT C.ContentID, C.ContentName, CC.ContentCategoryName , C.ContentEntranceDate FROM Content C 
	LEFT JOIN ContentCategory CC ON CC.ContentCategoryID = C.ContentCategoryID 
	WHERE C.ContentCategoryID  = (CASE @ContentCategoryID WHEN 0 THEN C.ContentCategoryID ELSE @ContentCategoryID END)
	and ContentIsDraft = @IsDraft 
END



GO
/****** Object:  StoredProcedure [dbo].[cLoadContentParamByContentID]    Script Date: 23.01.2020 14:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[cLoadContentParamByContentID]
	@ContentID int 
AS
BEGIN
	
	SELECT * FROM Content C
	LEFT JOIN ContentCategory CC ON CC.ContentCategoryID =C.ContentCategoryID 
	LEFT JOIN Language L ON L.LanguageID = C.ContentLanguageID 
	  WHERE C.ContentID= @ContentID
	
	
	 
END

GO
/****** Object:  StoredProcedure [dbo].[cLoadContentParamByContentLanguageID]    Script Date: 23.01.2020 14:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE  [dbo].[cLoadContentParamByContentLanguageID]
	@ContentLanguageID int 
AS
BEGIN
	
	
	SET NOCOUNT ON;

    
	SELECT * FROM Content WHERE ContentLanguageID  = (CASE @ContentLanguageID WHEN 0 THEN ContentLanguageID ELSE @ContentLanguageID END)
	AND ContentIsActive =1 
END



GO
/****** Object:  StoredProcedure [dbo].[cLoadContentSoftSkill]    Script Date: 23.01.2020 14:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[cLoadContentSoftSkill]
	
AS
BEGIN
	
	SELECT * FROM ContentSoftSkill CS
	LEFT JOIN SoftSkill SS ON SS.SoftSkillID =CS.SoftSkillID
	where CS.[IsActive]=1 
	
	
	 
END

GO
/****** Object:  StoredProcedure [dbo].[cLoadContentSoftSkillParamByContentID]    Script Date: 23.01.2020 14:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[cLoadContentSoftSkillParamByContentID]
	@ContentID int 
AS
BEGIN
	
	SELECT * FROM ContentSoftSkill CS
	LEFT JOIN SoftSkill SS ON SS.SoftSkillID =CS.SoftSkillID
	where CS.[IsActive]=1 
	AND CS.ContentID = @ContentID
	
	
	 
END

GO
/****** Object:  StoredProcedure [dbo].[cLoadDepartment]    Script Date: 23.01.2020 14:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[cLoadDepartment]
	
AS
BEGIN
	
	SELECT * FROM Department WHERE DepartmentIsActive=1 
	
	
	 
END

GO
/****** Object:  StoredProcedure [dbo].[cLoadDepartmentParamByDepartmentID]    Script Date: 23.01.2020 14:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[cLoadDepartmentParamByDepartmentID]
	@DepartmentID int 
AS
BEGIN
	
	SELECT * FROM Department WHERE DepartmentID = @DepartmentID  AND DepartmentIsActive=1 
	
	
	 
END

GO
/****** Object:  StoredProcedure [dbo].[cLoadDraftContent]    Script Date: 23.01.2020 14:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[cLoadDraftContent]
	
AS
BEGIN
	
	SELECT * FROM DraftContent DC
	LEFT JOIN ContentCategory CC (NOLOCK) ON CC.ContentCategoryID = DC.DraftContentCategoryID
	where DC.DraftContentIsActive=1 AND CC.ContentCategoryIsActive =1  
	
	
	 
END

GO
/****** Object:  StoredProcedure [dbo].[cLoadDraftContentParamByContentCategoryID]    Script Date: 23.01.2020 14:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE  [dbo].[cLoadDraftContentParamByContentCategoryID]
	@ContentCategoryID int 
AS
BEGIN
	
	
	SET NOCOUNT ON;

    
	SELECT * FROM Content WHERE ContentCategoryID  = (CASE @ContentCategoryID WHEN 0 THEN ContentCategoryID ELSE @ContentCategoryID END)
	and ContentIsDraft = 0 
END



GO
/****** Object:  StoredProcedure [dbo].[cLoadGallery]    Script Date: 23.01.2020 14:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[cLoadGallery]
	
AS
BEGIN
	
	SELECT G.GalleryID, G.GalleryFolder , ISNULL(C.CompanyName,'Hepsi') CompanyName    FROM Gallery G
	LEFT JOIN Company C (NOLOCK) ON C.CompanyID = G.CompanyID 
	WHERE G.GalleryIsActive =1 
	AND ISNULL(C.CompanyIsActive,1)=1
	ORDER BY G.GalleryID DESC
	
	
	 
END

GO
/****** Object:  StoredProcedure [dbo].[cLoadGalleryParamByCompanyID]    Script Date: 23.01.2020 14:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[cLoadGalleryParamByCompanyID]
	@CompanyID int 
AS
BEGIN
	
	SELECT * FROM  Gallery where ISNULL(CompanyID,0)  =(CASE @CompanyID WHEN 0 THEN ISNULL(CompanyID,0) ELSE @CompanyID END) and GalleryIsActive = 1 
	
	
	 
END

GO
/****** Object:  StoredProcedure [dbo].[cLoadGalleryParamByGalleryID]    Script Date: 23.01.2020 14:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[cLoadGalleryParamByGalleryID]
	@GalleryID int 
AS
BEGIN
	
	SELECT * FROM  Gallery  WHERE GalleryID  =@GalleryID 
	
	
	 
END

GO
/****** Object:  StoredProcedure [dbo].[cLoadLanguage]    Script Date: 23.01.2020 14:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[cLoadLanguage]
	
AS
BEGIN
	
	SELECT * FROM Language  
	
	
	 
END

GO
/****** Object:  StoredProcedure [dbo].[cLoadLanguageParamByLanguageID]    Script Date: 23.01.2020 14:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[cLoadLanguageParamByLanguageID]
	@LanguageID int 
AS
BEGIN
	
	SELECT * FROM Language WHERE LanguageID= @LanguageID 
	
	
	 
END

GO
/****** Object:  StoredProcedure [dbo].[cLoadMainContentCategory]    Script Date: 23.01.2020 14:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[cLoadMainContentCategory]
	
AS
BEGIN
	
	SELECT * FROM MainContentCategory
	
	 
END

GO
/****** Object:  StoredProcedure [dbo].[cLoadMember]    Script Date: 23.01.2020 14:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[cLoadMember]
	
AS
BEGIN
	
	SELECT * FROM Member  M 
	LEFT JOIN MemberGroup MG  (NOLOCK) ON MG.MemberGroupID = M.MemberGroupID
	LEFT JOIN Company C (NOLOCK) ON C.CompanyID= M.MemberCompanyID
	Where MemberIsActive =1  
	ORDER BY MemberID DESC 
	
	 
END

GO
/****** Object:  StoredProcedure [dbo].[cLoadMemberGroup]    Script Date: 23.01.2020 14:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[cLoadMemberGroup]
	
AS
BEGIN
	
	SELECT * FROM MemberGroup
	
	 
END

GO
/****** Object:  StoredProcedure [dbo].[cLoadMemberParamByMemberID]    Script Date: 23.01.2020 14:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[cLoadMemberParamByMemberID]
	@MemberID int 
AS
BEGIN
	
	SELECT * FROM Member M 
	LEFT JOIN MemberGroup MG ON MG.MemberGroupID = M.MemberGroupID
	LEFT JOIN Company C ON C.CompanyID = M.MemberCompanyID 
	WHERE MemberID = @MemberID
	AND M.MemberIsActive =1 
	
	 
END

GO
/****** Object:  StoredProcedure [dbo].[cLoadRole]    Script Date: 23.01.2020 14:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[cLoadRole] 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT * FROM Role Where RoleIsActive =1  order by RoleID DESC
END

GO
/****** Object:  StoredProcedure [dbo].[cLoadRoleParamByRoleID]    Script Date: 23.01.2020 14:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[cLoadRoleParamByRoleID] 
	@RoleID int 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT * FROM Role Where  RoleID = @RoleID
END

GO
/****** Object:  StoredProcedure [dbo].[cLoadSampleContent]    Script Date: 23.01.2020 14:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[cLoadSampleContent]
	
AS
BEGIN
	
	SELECT * FROM SampleContent SC
	LEFT JOIN ContentCategory CC (NOLOCK) ON CC.ContentCategoryID = SC.SampleContentCategoryID
	LEFT JOIN Language L (NOLOCK) ON L.LanguageID = SC.SampleContentLanguageID
	where SC.SampleContentIsActive=1 AND CC.ContentCategoryIsActive =1  
	AND L.LanguageIsActive =1 
	ORDER BY SC.SampleContentID DESC 
	
	 
END

GO
/****** Object:  StoredProcedure [dbo].[cLoadSampleContentParamByContentCategoryID]    Script Date: 23.01.2020 14:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[cLoadSampleContentParamByContentCategoryID]
	@ContentCategoryID	int 
AS
BEGIN
	
	SELECT * FROM SampleContent SC 
	LEFT JOIN ContentCategory CC ON CC.ContentCategoryID =SC.SampleContentCategoryID
	where SC.SampleContentIsActive=1 
	AND SC.SampleContentCategoryID =  (CASE @ContentCategoryID WHEN 0 THEN SC.SampleContentCategoryID ELSE @ContentCategoryID END)
	
	
	 
END

GO
/****** Object:  StoredProcedure [dbo].[cLoadSampleContentParamBySampleContentID]    Script Date: 23.01.2020 14:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[cLoadSampleContentParamBySampleContentID]
	@SampleContentID int 
AS
BEGIN
	
	SELECT * FROM SampleContent SC
	LEFT JOIN ContentCategory CC (NOLOCK) ON CC.ContentCategoryID = SC.SampleContentCategoryID
	LEFT JOIN Language L (NOLOCK) ON L.LanguageID = SC.SampleContentLanguageID 
	WHERE SC.SampleContentIsActive =1 
	AND SC.SampleContentID = @SampleContentID
	
	
	 
END

GO
/****** Object:  StoredProcedure [dbo].[cLoadSampleContentTop]    Script Date: 23.01.2020 14:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[cLoadSampleContentTop]
AS
BEGIN
	
	SELECT TOP 1  * FROM SampleContent SC
	LEFT JOIN ContentCategory CC (NOLOCK) ON CC.ContentCategoryID = SC.SampleContentCategoryID
	LEFT JOIN Language L (NOLOCK) ON L.LanguageID = SC.SampleContentLanguageID
	where SC.SampleContentIsActive=1 AND CC.ContentCategoryIsActive =1  
	AND L.LanguageIsActive =1 
	ORDER BY SC.SampleContentID DESC 
	
	
	 
END

GO
/****** Object:  StoredProcedure [dbo].[cLoadSoftSkill]    Script Date: 23.01.2020 14:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[cLoadSoftSkill]
	
AS
BEGIN
	
	SELECT * FROM SoftSkill SS
	LEFT JOIN Company C ON C.CompanyID = SS.CompanyID
	 Where SoftSkillIsActive=1 
	
	 
END

GO
/****** Object:  StoredProcedure [dbo].[cLoadSoftSkillsParamBySoftSkillID]    Script Date: 23.01.2020 14:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[cLoadSoftSkillsParamBySoftSkillID]
	@SoftSkillID int 
	
AS
BEGIN
	
	SELECT * FROM SoftSkill  WHERE SoftSkillID =@SoftSkillID
	
	 
	
	 
END

GO
/****** Object:  StoredProcedure [dbo].[cLoadTemplate]    Script Date: 23.01.2020 14:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[cLoadTemplate]
	
AS
BEGIN
	
	SELECT * FROM Template Where TemplateIsActive=1 
	
	 
END

GO
/****** Object:  StoredProcedure [dbo].[cLoadTemplateParamByTemplateID]    Script Date: 23.01.2020 14:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[cLoadTemplateParamByTemplateID]
	@TemplateID int 
AS
BEGIN
	
	SELECT * FROM Template  WHERE TemplateID = @TemplateID AND TemplateIsActive=1 
	
	
	 
END

GO
/****** Object:  StoredProcedure [dbo].[cSaveCompany]    Script Date: 23.01.2020 14:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[cSaveCompany]
	@CompanyID int, 
	@CompanyName nvarchar(50), 
	@CompanyOpenningTextTR NVARCHAR(MAX), 
	@CompanyClosingTextTR NVARCHAR(MAX),
	@CompanyOpenningTextEN NVARCHAR(MAX), 
	@CompanyClosingTextEN NVARCHAR(MAX),
	@CompanyIsActive bit
AS
BEGIN
	
	IF @CompanyID > 0
	BEGIN
		UPDATE
			 Company
		SET
				CompanyName=@CompanyName, 
				CompanyOpenningTextTR=@CompanyOpenningTextTR,
				CompanyClosingTextTR=@CompanyClosingTextTR,
				CompanyOpenningTextEN=@CompanyOpenningTextEN,
				CompanyClosingTextEN=@CompanyClosingTextEN,
				CompanyIsActive =@CompanyIsActive 
		WHERE
			CompanyID = @CompanyID
			
			return @CompanyID;
	END	
	ELSE
	BEGIN
		
		INSERT INTO
			Company
			( CompanyName, CompanyOpenningTextTR,CompanyClosingTextTR,CompanyOpenningTextEN,CompanyClosingTextEN,CompanyIsActive)
		VALUES 
			(@CompanyName, @CompanyOpenningTextTR,@CompanyClosingTextTR,@CompanyOpenningTextEN,@CompanyClosingTextEN,@CompanyIsActive)

		return @@IDENTITY
		
	 
	END
	
	 
END

GO
/****** Object:  StoredProcedure [dbo].[cSaveContent]    Script Date: 23.01.2020 14:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[cSaveContent]
	@ContentID int, 
	@ContentName nvarchar(50), 
	@ContentDescription nvarchar(max), 
	@ContentHTML nvarchar(max), 
	@ContentLanguageID int ,
	@ContentCompanyID int ,
	@ContentRoleID int ,
	@ContentGalleryID int ,
	@ContentTemplateID int ,
	@ContentCategoryID int , 
	@ContentEnterBy int, 
	@ContentIsDraft bit, 
	@ContentIsActive bit
AS
BEGIN
	
	IF @ContentID > 0
	BEGIN
		UPDATE
			 Content
		SET
				ContentName=@ContentName, 
				ContentDescription=@ContentDescription, 
				ContentHTML=@ContentHTML, 
				ContentLanguageID = @ContentLanguageID  ,
				ContentCompanyID=@ContentCompanyID  ,
				ContentRoleID = @ContentRoleID  ,
				ContentGalleryID= @ContentGalleryID  ,
				ContentTemplateID =@ContentTemplateID  ,
				ContentCategoryID=@ContentCategoryID,
				ContentIsDraft=@ContentIsDraft, 
				ContentUpdateDate= GETDATE(),
				ContentIsActive =@ContentIsActive 
		WHERE
			ContentID = @ContentID
		return @ContentID;
	END	
	ELSE
	BEGIN
		
		INSERT INTO
			Content
			( ContentName, ContentDescription, ContentHTML, ContentLanguageID,ContentCompanyID,ContentRoleID,ContentGalleryID,ContentTemplateID,
			ContentCategoryID,ContentEntranceDate, ContentEnterBy, ContentIsDraft, ContentIsActive)
		VALUES 
			(@ContentName, @ContentDescription, @ContentHTML, @ContentLanguageID,@ContentCompanyID,@ContentRoleID,@ContentGalleryID,@ContentTemplateID,
			@ContentCategoryID, GETDATE(), @ContentEnterBy, @ContentIsDraft, @ContentIsActive)

		return @@IDENTITY
		
	 
	END
	
	 
END

GO
/****** Object:  StoredProcedure [dbo].[cSaveContentCategory]    Script Date: 23.01.2020 14:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[cSaveContentCategory]
	@ContentCategoryID int, 
	@MainContentCategoryID int, 
	@ContentCategoryName nvarchar(50), 
	@ContentCategoryLogo nvarchar(150),
	@ContentCategoryIsActive bit
AS
BEGIN
	
	IF @ContentCategoryID > 0
	BEGIN
		UPDATE
			 ContentCategory
		SET
			MainContentCategoryID=@MainContentCategoryID,
			ContentCategoryName=@ContentCategoryName, 
			ContentCategoryLogo=@ContentCategoryLogo,
			ContentCategoryIsActive =@ContentCategoryIsActive 
		WHERE
			ContentCategoryID = @ContentCategoryID
			
			return @ContentCategoryID;
	END	
	ELSE
	BEGIN
		
		INSERT INTO
			ContentCategory
			( MainContentCategoryID,ContentCategoryName,ContentCategoryLogo, ContentCategoryIsActive)
		VALUES 
			(@MainContentCategoryID, @ContentCategoryName,@ContentCategoryLogo, @ContentCategoryIsActive)

		return @@IDENTITY
		
	 
	END
	
	 
END

GO
/****** Object:  StoredProcedure [dbo].[cSaveDepartment]    Script Date: 23.01.2020 14:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[cSaveDepartment]
	@DepartmentID int, 
	@DepartmentName nvarchar(50), 
	@DepartmentIsActive bit
AS
BEGIN
	
	IF @DepartmentID > 0
	BEGIN
		UPDATE
			 Department
		SET
				DepartmentName=@DepartmentName, 
				DepartmentIsActive =@DepartmentIsActive 
		WHERE
			DepartmentID = @DepartmentID
			
			return @DepartmentID;
	END	
	ELSE
	BEGIN
		
		INSERT INTO
			Department
			( DepartmentName, DepartmentIsActive)
		VALUES 
			(@DepartmentName, @DepartmentIsActive)

		return @@IDENTITY
		
	 
	END
	
	 
END

GO
/****** Object:  StoredProcedure [dbo].[cSaveGallery]    Script Date: 23.01.2020 14:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[cSaveGallery]
	@GalleryID int, 
	@CompanyID int, 
	@GalleryFolder nvarchar(250), 
	@GalleryIsActive bit
AS
BEGIN
	
	IF @GalleryID > 0
	BEGIN
		UPDATE
			 Gallery
		SET
				CompanyID=@CompanyID, 
				GalleryFolder=@GalleryFolder,
				GalleryIsActive =@GalleryIsActive
		WHERE
			GalleryID = @GalleryID
			
			return @GalleryID;
	END	
	ELSE
	BEGIN
		
		INSERT INTO
			Gallery
			(  CompanyID, GalleryFolder, GalleryIsActive)
		VALUES 
			(@CompanyID, @GalleryFolder, @GalleryIsActive)

		return @@IDENTITY
		
	 
	END
	
	 
END

GO
/****** Object:  StoredProcedure [dbo].[cSaveLanguage]    Script Date: 23.01.2020 14:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[cSaveLanguage]
	@LanguageID int, 
	@LanguageCode nvarchar(2), 
	@LanguageName nvarchar(25), 
	@LanguageIsActive bit
AS
BEGIN
	
	IF @LanguageID > 0
	BEGIN
		UPDATE
			 Language
		SET
				LanguageCode=@LanguageCode, 
				LanguageName =@LanguageName 
		WHERE
			LanguageID = @LanguageID
			
			return @LanguageID;
	END	
	ELSE
	BEGIN
		
		INSERT INTO
			Language
			(  LanguageCode, LanguageName, LanguageIsActive)
		VALUES 
			(@LanguageCode, @LanguageName, @LanguageIsActive)

		return @@IDENTITY
		
	 
	END
	
	 
END

GO
/****** Object:  StoredProcedure [dbo].[cSaveMember]    Script Date: 23.01.2020 14:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[cSaveMember]
	@MemberID int, 
	@MemberName nvarchar(50), 
	@MemberSurname nvarchar(50), 
	@MemberEMail nvarchar(50), 
	@MemberPhone nvarchar(15), 
	@MemberPassword nvarchar(255), 
	@MemberGroupID int, 
	@MemberCompanyID int, 
	@MemberIsActive bit
AS
BEGIN
	
	IF @MemberID > 0
		UPDATE
			Member
		SET
			MemberName=@MemberName, 
			MemberSurname=@MemberSurname, 
			MemberEMail=@MemberEMail, 
			MemberPhone=@MemberPhone, 
			MemberPassword=@MemberPassword, 
			MemberGroupID=@MemberGroupID, 
			MemberCompanyID=@MemberCompanyID, 
			MemberIsActive=@MemberIsActive
			WHERE
			MemberID = @MemberID
			
			
	ELSE
	BEGIN
		INSERT INTO
			Member
				(MemberName, MemberSurname, MemberEMail, MemberPhone, MemberPassword,  
				MemberGroupID, MemberCompanyID,  MemberEntranceDate,  MemberIsActive)
		VALUES 
			(@MemberName, @MemberSurname, @MemberEMail, @MemberPhone, @MemberPassword,  
			@MemberGroupID, @MemberCompanyID,  GETDATE(),  @MemberIsActive)

		
		return @@IDENTITY 
	 
	END
	
	 
END

GO
/****** Object:  StoredProcedure [dbo].[cSaveRole]    Script Date: 23.01.2020 14:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[cSaveRole]
	@RoleID int, 
	@RoleName nvarchar(50), 
	@RoleOpenningTextTR NVARCHAR(MAX), 
	@RoleClosingTextTR NVARCHAR(MAX),
	@RoleOpenningTextEN NVARCHAR(MAX), 
	@RoleClosingTextEN NVARCHAR(MAX),
	@RoleIsActive bit
AS
BEGIN
	
	IF @RoleID > 0
	BEGIN
		UPDATE
			 Role
		SET
			RoleName=@RoleName,
			RoleOpenningTextTR=@RoleOpenningTextTR,
			RoleClosingTextTR=@RoleClosingTextTR,
			RoleOpenningTextEN=@RoleOpenningTextEN,
			RoleClosingTextEN=@RoleClosingTextEN,
			RoleIsActive =@RoleIsActive
		WHERE
			RoleID = @RoleID
			
			return @RoleID;
	END	
	ELSE
	BEGIN
		
		INSERT INTO
			Role
			(   RoleName,RoleOpenningTextTR,RoleClosingTextTR,RoleOpenningTextEN,RoleClosingTextEN, RoleIsActive)
		VALUES 
			(@RoleName, @RoleOpenningTextTR,@RoleClosingTextTR,@RoleOpenningTextEN,@RoleClosingTextEN,@RoleIsActive)

		return @@IDENTITY
		
	 
	END
	
	 
END

GO
/****** Object:  StoredProcedure [dbo].[cSaveSampleContent]    Script Date: 23.01.2020 14:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[cSaveSampleContent]
	@SampleContentID int, 
	@SampleContentName nvarchar(125), 
	@SampleContentLanguageID int, 
	@SampleContentCategoryID int, 
	@SampleContentHTML nvarchar(max), 
	@SampleContentIsActive bit
AS
BEGIN
	
	IF @SampleContentID > 0
	BEGIN
		UPDATE
			 SampleContent
		SET
				SampleContentName=@SampleContentName, 
				SampleContentLanguageID=@SampleContentLanguageID, 
				SampleContentCategoryID=@SampleContentCategoryID, 
				SampleContentHTML=@SampleContentHTML, 
				SampleContentIsActive=@SampleContentIsActive
		WHERE
			SampleContentID = @SampleContentID
		return @SampleContentID;
	END	
	ELSE
	BEGIN
		
		INSERT INTO
			SampleContent
			(SampleContentName, SampleContentLanguageID, SampleContentCategoryID, SampleContentHTML, SampleContentEntranceDate, SampleContentIsActive)
		VALUES 
			(@SampleContentName, @SampleContentLanguageID, @SampleContentCategoryID, @SampleContentHTML, GETDATE(), @SampleContentIsActive)

		return @@IDENTITY
		
	 
	END
	
	 
END

GO
/****** Object:  StoredProcedure [dbo].[cSaveSoftSkill]    Script Date: 23.01.2020 14:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[cSaveSoftSkill]
	@SoftSkillID int, 
	@SoftSkillTag nvarchar(50), 
	@SoftSkillOpenningTextTR nvarchar(max),
	@SoftSkillClosingTextTR  nvarchar(max),
	@SoftSkillOpenningTextEN  nvarchar(max),
	@SoftSkillClosingTextEN  nvarchar(max),
	@CompanyID int ,
	@SoftSkillIsActive bit
AS
BEGIN
	
	IF @SoftSkillID > 0
	BEGIN
		UPDATE
			 SoftSkill
		SET
			SoftSkillTag=@SoftSkillTag,
			SoftSkillOpenningTextTR =@SoftSkillOpenningTextTR,
			SoftSkillClosingTextTR =@SoftSkillClosingTextTR,
			SoftSkillOpenningTextEN=@SoftSkillOpenningTextEN,
			SoftSkillClosingTextEN=@SoftSkillClosingTextEN,
			CompanyID=@CompanyID,
			SoftSkillIsActive=@SoftSkillIsActive
		WHERE
			SoftSkillID = @SoftSkillID
			
			return @SoftSkillID;
	END	
	ELSE
	BEGIN
		
		INSERT INTO
			SoftSkill
			(SoftSkillTag, SoftSkillOpenningTextTR, SoftSkillClosingTextTR,SoftSkillOpenningTextEN, SoftSkillClosingTextEN,CompanyID,SoftSkillIsActive)
		VALUES 
			(@SoftSkillTag, @SoftSkillOpenningTextTR, @SoftSkillClosingTextTR,@SoftSkillOpenningTextEN, @SoftSkillClosingTextEN,@CompanyID, @SoftSkillIsActive)

		return @@IDENTITY
		
	 
	END
	
	 
END

GO
/****** Object:  Table [dbo].[Company]    Script Date: 23.01.2020 14:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Company](
	[CompanyID] [int] IDENTITY(1,1) NOT NULL,
	[CompanyName] [nvarchar](50) NULL,
	[CompanyOpenningTextTR] [nvarchar](max) NULL,
	[CompanyClosingTextTR] [nvarchar](max) NULL,
	[CompanyOpenningTextEN] [nvarchar](max) NULL,
	[CompanyClosingTextEN] [nvarchar](max) NULL,
	[CompanyIsActive] [bit] NULL,
 CONSTRAINT [PK_Company] PRIMARY KEY CLUSTERED 
(
	[CompanyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Content]    Script Date: 23.01.2020 14:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Content](
	[ContentID] [int] IDENTITY(1,1) NOT NULL,
	[ContentName] [nvarchar](50) NULL,
	[ContentDescription] [nvarchar](max) NULL,
	[ContentHTML] [nvarchar](max) NULL,
	[ContentLanguageID] [int] NULL,
	[ContentCompanyID] [int] NULL,
	[ContentRoleID] [int] NULL,
	[ContentGalleryID] [int] NULL,
	[ContentTemplateID] [int] NULL,
	[ContentCategoryID] [int] NULL,
	[ContentEntranceDate] [datetime] NULL,
	[ContentUpdateDate] [datetime] NULL,
	[ContentEnterBy] [int] NULL,
	[ContentIsDraft] [bit] NULL,
	[ContentIsActive] [bit] NULL,
 CONSTRAINT [PK_Content] PRIMARY KEY CLUSTERED 
(
	[ContentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ContentCategory]    Script Date: 23.01.2020 14:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContentCategory](
	[ContentCategoryID] [int] IDENTITY(1,1) NOT NULL,
	[MainContentCategoryID] [int] NULL,
	[ContentCategoryName] [nvarchar](50) NULL,
	[ContentCategoryLogo] [nvarchar](150) NULL,
	[ContentCategoryIsActive] [bit] NULL,
 CONSTRAINT [PK_ContentCategory] PRIMARY KEY CLUSTERED 
(
	[ContentCategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ContentSoftSkill]    Script Date: 23.01.2020 14:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContentSoftSkill](
	[ContentSoftSkillID] [int] IDENTITY(1,1) NOT NULL,
	[ContentID] [int] NULL,
	[SoftSkillID] [int] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_ContentSoftSkill] PRIMARY KEY CLUSTERED 
(
	[ContentSoftSkillID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Department]    Script Date: 23.01.2020 14:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Department](
	[DepartmentID] [int] IDENTITY(1,1) NOT NULL,
	[DepartmentName] [nvarchar](25) NULL,
	[DepartmentIsActive] [bit] NULL,
 CONSTRAINT [PK_Department] PRIMARY KEY CLUSTERED 
(
	[DepartmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Gallery]    Script Date: 23.01.2020 14:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Gallery](
	[GalleryID] [int] IDENTITY(1,1) NOT NULL,
	[CompanyID] [int] NULL,
	[GalleryFolder] [nvarchar](125) NULL,
	[GalleryIsActive] [bit] NULL,
 CONSTRAINT [PK_Gallery] PRIMARY KEY CLUSTERED 
(
	[GalleryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[GalleryContentCategory]    Script Date: 23.01.2020 14:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GalleryContentCategory](
	[GalleryContentCategoryID] [int] IDENTITY(1,1) NOT NULL,
	[GalleryID] [int] NULL,
	[ContentCategoryID] [int] NULL,
	[GalleryContentCategoryIsActive] [bit] NULL,
 CONSTRAINT [PK_GalleryContentCategory] PRIMARY KEY CLUSTERED 
(
	[GalleryContentCategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Language]    Script Date: 23.01.2020 14:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Language](
	[LanguageID] [int] IDENTITY(1,1) NOT NULL,
	[LanguageCode] [nvarchar](2) NULL,
	[LanguageName] [nvarchar](25) NULL,
	[LanguageIsActive] [bit] NULL,
 CONSTRAINT [PK_Language] PRIMARY KEY CLUSTERED 
(
	[LanguageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MainContentCategory]    Script Date: 23.01.2020 14:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MainContentCategory](
	[MainContentCategoryID] [int] IDENTITY(1,1) NOT NULL,
	[MainContentCategoryName] [nvarchar](50) NULL,
 CONSTRAINT [PK_MainContentCategory] PRIMARY KEY CLUSTERED 
(
	[MainContentCategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Member]    Script Date: 23.01.2020 14:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Member](
	[MemberID] [int] IDENTITY(1,1) NOT NULL,
	[MemberName] [nvarchar](50) NULL,
	[MemberSurname] [nvarchar](50) NULL,
	[MemberEMail] [nvarchar](50) NULL,
	[MemberPhone] [nvarchar](15) NULL,
	[MemberPassword] [nvarchar](255) NULL,
	[MemberGroupID] [int] NULL,
	[MemberCompanyID] [int] NULL,
	[MemberEntranceDate] [datetime] NULL,
	[MemberActivatedDate] [datetime] NULL,
	[MemberIsActive] [bit] NULL,
 CONSTRAINT [PK_Member] PRIMARY KEY CLUSTERED 
(
	[MemberID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MemberGroup]    Script Date: 23.01.2020 14:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MemberGroup](
	[MemberGroupID] [int] IDENTITY(1,1) NOT NULL,
	[MemberGroupName] [nvarchar](25) NULL,
 CONSTRAINT [PK_MemberGroup] PRIMARY KEY CLUSTERED 
(
	[MemberGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Role]    Script Date: 23.01.2020 14:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[RoleID] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](25) NULL,
	[RoleOpenningTextTR] [nvarchar](max) NULL,
	[RoleClosingTextTR] [nvarchar](max) NULL,
	[RoleOpenningTextEN] [nvarchar](max) NULL,
	[RoleClosingTextEN] [nvarchar](max) NULL,
	[RoleIsActive] [bit] NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SampleContent]    Script Date: 23.01.2020 14:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SampleContent](
	[SampleContentID] [int] IDENTITY(1,1) NOT NULL,
	[SampleContentName] [nvarchar](125) NULL,
	[SampleContentLanguageID] [int] NULL,
	[SampleContentCategoryID] [int] NULL,
	[SampleContentHTML] [nvarchar](max) NULL,
	[SampleContentEntranceDate] [datetime] NULL,
	[SampleContentIsActive] [bit] NULL,
 CONSTRAINT [PK_SampleContent] PRIMARY KEY CLUSTERED 
(
	[SampleContentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SoftSkill]    Script Date: 23.01.2020 14:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SoftSkill](
	[SoftSkillID] [int] IDENTITY(1,1) NOT NULL,
	[CompanyID] [int] NULL,
	[SoftSkillTag] [nvarchar](50) NULL,
	[SoftSkillOpenningTextTR] [nvarchar](max) NULL,
	[SoftSkillClosingTextTR] [nvarchar](max) NULL,
	[SoftSkillOpenningTextEN] [nvarchar](max) NULL,
	[SoftSkillClosingTextEN] [nvarchar](max) NULL,
	[SoftSkillIsActive] [bit] NULL,
 CONSTRAINT [PK_SoftSkill] PRIMARY KEY CLUSTERED 
(
	[SoftSkillID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Template]    Script Date: 23.01.2020 14:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Template](
	[TemplateID] [int] IDENTITY(1,1) NOT NULL,
	[TemplateName] [nvarchar](150) NULL,
	[TemplateDescription] [nvarchar](max) NULL,
	[TemplateImage] [nvarchar](125) NULL,
	[TemplateHTML] [nvarchar](max) NULL,
	[TemplateIsActive] [bit] NULL,
 CONSTRAINT [PK_Template] PRIMARY KEY CLUSTERED 
(
	[TemplateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Company] ON 

INSERT [dbo].[Company] ([CompanyID], [CompanyName], [CompanyOpenningTextTR], [CompanyClosingTextTR], [CompanyOpenningTextEN], [CompanyClosingTextEN], [CompanyIsActive]) VALUES (1, N'Mannesman', N'Biz Borusan Mannesmann Boru olarak, 4.000 çeşit ürünümüzle başta inşaat, enerji ve otomotiv olmak üzere pek çok sektöre hizmet veriyor, İstanbul Sanayi Odası 500 (ISO 500) endeksinde 49. sırada yer alıyoruz. Türkiye’de de pazar lideri konumunda, 1500
kişilik işgücü ve 1,4 milyon tonluk çelik boru üretim kapasitemizle; su boruları, gaz boruları, genel amaçlı borular, doğal gaz ve petrol hat boruları, sanayi boru ve profilleri, sondaj boruları ve güçlendirilmiş çelik yapı profilleri üretiyor,
müşterilerimizin ve ülkemizin yaşam kalitesini artırmayı amaçlıyoruz.', N'dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with ', N'dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with ', N'dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with ', 1)
INSERT [dbo].[Company] ([CompanyID], [CompanyName], [CompanyOpenningTextTR], [CompanyClosingTextTR], [CompanyOpenningTextEN], [CompanyClosingTextEN], [CompanyIsActive]) VALUES (2, N'Borçelik', N'<p>BORÇELİK </p><p>standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with </p>', N'<p>BORÇELİK<br></p><p>dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with </p>', N'<p>BORÇELİK<br></p><p>dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with </p>', N'<p>BORÇELİK<br></p><p>dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with </p>', 1)
INSERT [dbo].[Company] ([CompanyID], [CompanyName], [CompanyOpenningTextTR], [CompanyClosingTextTR], [CompanyOpenningTextEN], [CompanyClosingTextEN], [CompanyIsActive]) VALUES (3, N'Borusan Otomotiv', N'dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry''s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with ', N'dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry''s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with ', N'dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry''s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with ', N'dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry''s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with ', 1)
INSERT [dbo].[Company] ([CompanyID], [CompanyName], [CompanyOpenningTextTR], [CompanyClosingTextTR], [CompanyOpenningTextEN], [CompanyClosingTextEN], [CompanyIsActive]) VALUES (4, N'Borusan Lojistik', N'dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry''s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with ', N'dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry''s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with ', N'dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry''s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with ', N'dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry''s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with ', 1)
SET IDENTITY_INSERT [dbo].[Company] OFF
SET IDENTITY_INSERT [dbo].[Content] ON 

INSERT [dbo].[Content] ([ContentID], [ContentName], [ContentDescription], [ContentHTML], [ContentLanguageID], [ContentCompanyID], [ContentRoleID], [ContentGalleryID], [ContentTemplateID], [ContentCategoryID], [ContentEntranceDate], [ContentUpdateDate], [ContentEnterBy], [ContentIsDraft], [ContentIsActive]) VALUES (1, N'Hoş Geldin', NULL, N'      <center>
                    <table bgcolor="white" id="Table_01" width="640" height="" border="0" cellpadding="0"
                        cellspacing="0" align="center">
                        <tr>
                            <td>
                                <img src="Uploads/testmail/images/index_01.png" width="640" height="396" alt=""></td>
                        </tr>
                        <tr>
                            <td
                                style="font-family: Arial; font-size: 15px; line-height: 22px; color: #333; padding: 40px;">
                                <h1>Türkiye''nin geleceğini inşa ediyoruz.</h1>
                                <br>
                                <p>Avrupa’nın önde gelen çelik boru üreticilerinden biri olan Borusan Mannesmann Boru’da
                                    yaşam kalitesini yükselten ürün ve hizmetler sunmak ve toplumun ekonomik, sosyal
                                    gelişimini üst seviyelere taşımak için <span contenteditable="">«Elektrik Bakım ve Otomasyon Mühendisi»</span>
                                    olarak çalışacak ekip arkadaşları arıyoruz.</p>
                                <p>Eğer sen de dinamik bir ortamda, harika takım arkadaşlarıyla zorlu işlerin üstesinden
                                    gelmek istiyorsan, Borusan Burada.</p>
                                <p>Biz Borusan Mannesmann Boru olarak, 4.000 çeşit ürünümüzle başta inşaat, enerji ve
                                    otomotiv olmak üzere pek çok sektöre hizmet veriyor, İstanbul Sanayi Odası 500 (ISO
                                    500) endeksinde 49. sırada yer alıyoruz. Türkiye’de de pazar lideri konumunda, 1500
                                    kişilik işgücü ve 1,4 milyon tonluk çelik boru üretim kapasitemizle; su boruları,
                                    gaz boruları, genel amaçlı borular, doğal gaz ve petrol hat boruları, sanayi boru ve
                                    profilleri, sondaj boruları ve güçlendirilmiş çelik yapı profilleri üretiyor,
                                    müşterilerimizin ve ülkemizin yaşam kalitesini artırmayı amaçlıyoruz.</p>
                                <p><strong>Senden Neler Bekliyoruz?</strong><br />Gerçek mühendislik sorunları ile ilgilenip işini en iyi
                                    şekilde yapman için ileri teknolojiye sahip fırsatlar sunuyoruz. Tüm bunları
                                    yaparken senden beklediklerimiz:</p>
                                <p><span contenteditable="">• Mevcut hatlardaki arızaları tespit etmen ve ilgilenecek ekibi
                                        yönlendirmeni,<br />Planlı bakım programlarını hazırlanmasını, güncellenmesini ve
                                        bakımların gerçekleştirilmesini sağlaman,<br />• Yeni kurulacak hatlarda yüklenici
                                        firmalarla elektrik ve otomasyon işleri konusunda iletişimi yürütülüp şirket
                                        yükümlülüklerinin yapılması için gerekli aksiyonları planlanıp yerine
                                        getirmen,<br />• Öz kaynaklarla yapılan projelerin elektriksel şemalarını
                                        tasarlaman, gerekli malzemelerin seçimini yapman ve PLC programını yazılıp sistemi
                                        devreye alman,<br />• Otomasyon sektöründe gelişmeleri takip etmen ve mevcut
                                        işleyişi geliştirmek için bunları var olan uygulamalara uyarlaman,<br />• İç
                                        müşterilerin ihtiyaçları doğrultusunda otomasyon projelerini geliştirilip bunu iç ya
                                        da dış kaynaklarla yürütülmesini organize etmen.</span></p>
                                <p><span contenteditable=""><strong>Neden sen?</strong><br />• Üniversitelerin Elektrik, Elektronik, Mekatronik, Kontrol ve
                                    Otomasyon bölümlerinden mezunuysan,<br />• En az bir programlama diline hâkimsen ve
                                    algoritma geliştirebiliyorsan,<br />• Yoğun iş temposuna ayak
                                    uydurabiliyorsan,<br />• İş süreçlerinde kullanmak için iyi derecede İngilizce
                                    biliyorsan,<br />• Tercihen PLC, sürücüler, HMI''lar ve diğer endüstriyel ekipmanlar
                                    ile uygulamalar yapıp devreye alıyor, otomasyon kontrol panoları tasarlıyor,
                                    imalatını yapıyor ya da katkıda bulunuyorsan,<br />• Şema çizim programlarını
                                    kullanabiliyorsan,</span></p>
                                <p><span contenteditable="">Aradığımız kişi sen olabilirsin.</span></p>
                                <p><strong>Öne çıkmak için neye ihtiyacın var?</strong> <br />• Kendini ve işini sürekli güncelleyebilmen
                                    için yenilikçi ve araştırmacı bir ruha sahip olmalısın.<br />• Gerekli durumlarda
                                    ekibe koçluk edip, doğru zamanda doğru yerde olmalarını sağlamalısın.<br />• Zorlu
                                    durumlar ve kişiler ile başa çıkabilecek ikna yeteneğine sahip olmalısın. <br />∙
                                    Kriz durumlarında oluşabilecek stresi iyi yönetebilmeli, kritik anlarda bile çözüm
                                    odaklı olmalısın. <br />• Doğru organizasyon ve planlama ile zaman yönetimini en
                                    verimli şekilde kullanmalısın.</p>
                                <p><strong>Borusan’da biz:</strong><br />• Kendimizi geliştirmek için işimizi geliştirir; yeni bilgi ve
                                    beceriler edinerek, yeni sorumluluklar üstleniriz. Bilgiye karşı her zaman merak
                                    duyar, araştırır; yaşam boyu öğrenmenin gücüne inanırız.<br />• Gelecek için ortak
                                    hayaller kurar, hayallerimizi hayata geçirirken önceliklerimizi doğru belirler,
                                    çeviklikle harekete geçeriz. Pazarı, teknolojiyi, trendleri ve rakipleri yakından
                                    takip eder; pazardaki fırsatları en iyi şekilde değerlendirerek fark yaratırız. Her
                                    zaman işimizi daha iyi yapmanın yollarını ararız.<br />• Biliriz ki başarıya ancak
                                    açık ve şeffaf iletişim kuran, ortak akılla hareket eden takımlarla ulaşabiliriz. Bu
                                    nedenle daha iyiye ulaşmak için fikirlerimizi cesurca söyler, birbirimizin
                                    görüşlerini yapıcı bir şekilde sorgularız.<br />• İnsana ve çevreye değer veririz.
                                    Güçlü yan haklar ve kulüpler ile sosyal hayatımızın desteklendiğini bilir, sosyal
                                    sorumluluk projeleriyle iyilik peşinde koşarız.</p>
                                <p>Çünkü Borusan Burada!<br />İşe Alım Süreci Nasıl İşleyecek?<br />Aklına takılan tüm
                                    sorular için cevaplar burada!</p>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <img src="Uploads/testmail/images/index_03.png" width="640" height="130" alt=""></td>
                        </tr>
                        <tr>
                            <td>
                                <img src="Uploads/testmail/images/index_04.png" width="640" height="1" alt=""></td>
                        </tr>
                        <tr>
                            <td>
                                <table id="Table_01" width="640" height="99" border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td>
                                            <img src="Uploads/testmail/images/social_01.png" width="297" height="99"
                                                alt=""></td>
                                        <td>
                                            <img src="Uploads/testmail/images/social_02.png" width="47" height="99"
                                                alt=""></td>
                                        <td>
                                            <img src="Uploads/testmail/images/social_03.png" width="296" height="99"
                                                alt=""></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </center>', 1, 1, 1, 1, 1, 1, CAST(N'2019-12-09 18:02:36.510' AS DateTime), NULL, 1, 0, 1)
INSERT [dbo].[Content] ([ContentID], [ContentName], [ContentDescription], [ContentHTML], [ContentLanguageID], [ContentCompanyID], [ContentRoleID], [ContentGalleryID], [ContentTemplateID], [ContentCategoryID], [ContentEntranceDate], [ContentUpdateDate], [ContentEnterBy], [ContentIsDraft], [ContentIsActive]) VALUES (2, N'Welcome', NULL, N'      <center>
                    <table bgcolor="white" id="Table_01" width="640" height="" border="0" cellpadding="0"
                        cellspacing="0" align="center">
                        <tr>
                            <td>
                                <img src="Uploads/testmail/images/index_01.png" width="640" height="396" alt=""></td>
                        </tr>
                        <tr>
                            <td
                                style="font-family: Arial; font-size: 15px; line-height: 22px; color: #333; padding: 40px;">
                                <h1>Türkiye''nin geleceğini inşa ediyoruz.</h1>
                                <br>
                                <p>Avrupa’nın önde gelen çelik boru üreticilerinden biri olan Borusan Mannesmann Boru’da
                                    yaşam kalitesini yükselten ürün ve hizmetler sunmak ve toplumun ekonomik, sosyal
                                    gelişimini üst seviyelere taşımak için <span contenteditable="">«Elektrik Bakım ve Otomasyon Mühendisi»</span>
                                    olarak çalışacak ekip arkadaşları arıyoruz.</p>
                                <p>Eğer sen de dinamik bir ortamda, harika takım arkadaşlarıyla zorlu işlerin üstesinden
                                    gelmek istiyorsan, Borusan Burada.</p>
                                <p>Biz Borusan Mannesmann Boru olarak, 4.000 çeşit ürünümüzle başta inşaat, enerji ve
                                    otomotiv olmak üzere pek çok sektöre hizmet veriyor, İstanbul Sanayi Odası 500 (ISO
                                    500) endeksinde 49. sırada yer alıyoruz. Türkiye’de de pazar lideri konumunda, 1500
                                    kişilik işgücü ve 1,4 milyon tonluk çelik boru üretim kapasitemizle; su boruları,
                                    gaz boruları, genel amaçlı borular, doğal gaz ve petrol hat boruları, sanayi boru ve
                                    profilleri, sondaj boruları ve güçlendirilmiş çelik yapı profilleri üretiyor,
                                    müşterilerimizin ve ülkemizin yaşam kalitesini artırmayı amaçlıyoruz.</p>
                                <p><strong>Senden Neler Bekliyoruz?</strong><br />Gerçek mühendislik sorunları ile ilgilenip işini en iyi
                                    şekilde yapman için ileri teknolojiye sahip fırsatlar sunuyoruz. Tüm bunları
                                    yaparken senden beklediklerimiz:</p>
                                <p><span contenteditable="">• Mevcut hatlardaki arızaları tespit etmen ve ilgilenecek ekibi
                                        yönlendirmeni,<br />Planlı bakım programlarını hazırlanmasını, güncellenmesini ve
                                        bakımların gerçekleştirilmesini sağlaman,<br />• Yeni kurulacak hatlarda yüklenici
                                        firmalarla elektrik ve otomasyon işleri konusunda iletişimi yürütülüp şirket
                                        yükümlülüklerinin yapılması için gerekli aksiyonları planlanıp yerine
                                        getirmen,<br />• Öz kaynaklarla yapılan projelerin elektriksel şemalarını
                                        tasarlaman, gerekli malzemelerin seçimini yapman ve PLC programını yazılıp sistemi
                                        devreye alman,<br />• Otomasyon sektöründe gelişmeleri takip etmen ve mevcut
                                        işleyişi geliştirmek için bunları var olan uygulamalara uyarlaman,<br />• İç
                                        müşterilerin ihtiyaçları doğrultusunda otomasyon projelerini geliştirilip bunu iç ya
                                        da dış kaynaklarla yürütülmesini organize etmen.</span></p>
                                <p><span contenteditable=""><strong>Neden sen?</strong><br />• Üniversitelerin Elektrik, Elektronik, Mekatronik, Kontrol ve
                                    Otomasyon bölümlerinden mezunuysan,<br />• En az bir programlama diline hâkimsen ve
                                    algoritma geliştirebiliyorsan,<br />• Yoğun iş temposuna ayak
                                    uydurabiliyorsan,<br />• İş süreçlerinde kullanmak için iyi derecede İngilizce
                                    biliyorsan,<br />• Tercihen PLC, sürücüler, HMI''lar ve diğer endüstriyel ekipmanlar
                                    ile uygulamalar yapıp devreye alıyor, otomasyon kontrol panoları tasarlıyor,
                                    imalatını yapıyor ya da katkıda bulunuyorsan,<br />• Şema çizim programlarını
                                    kullanabiliyorsan,</span></p>
                                <p><span contenteditable="">Aradığımız kişi sen olabilirsin.</span></p>
                                <p><strong>Öne çıkmak için neye ihtiyacın var?</strong> <br />• Kendini ve işini sürekli güncelleyebilmen
                                    için yenilikçi ve araştırmacı bir ruha sahip olmalısın.<br />• Gerekli durumlarda
                                    ekibe koçluk edip, doğru zamanda doğru yerde olmalarını sağlamalısın.<br />• Zorlu
                                    durumlar ve kişiler ile başa çıkabilecek ikna yeteneğine sahip olmalısın. <br />∙
                                    Kriz durumlarında oluşabilecek stresi iyi yönetebilmeli, kritik anlarda bile çözüm
                                    odaklı olmalısın. <br />• Doğru organizasyon ve planlama ile zaman yönetimini en
                                    verimli şekilde kullanmalısın.</p>
                                <p><strong>Borusan’da biz:</strong><br />• Kendimizi geliştirmek için işimizi geliştirir; yeni bilgi ve
                                    beceriler edinerek, yeni sorumluluklar üstleniriz. Bilgiye karşı her zaman merak
                                    duyar, araştırır; yaşam boyu öğrenmenin gücüne inanırız.<br />• Gelecek için ortak
                                    hayaller kurar, hayallerimizi hayata geçirirken önceliklerimizi doğru belirler,
                                    çeviklikle harekete geçeriz. Pazarı, teknolojiyi, trendleri ve rakipleri yakından
                                    takip eder; pazardaki fırsatları en iyi şekilde değerlendirerek fark yaratırız. Her
                                    zaman işimizi daha iyi yapmanın yollarını ararız.<br />• Biliriz ki başarıya ancak
                                    açık ve şeffaf iletişim kuran, ortak akılla hareket eden takımlarla ulaşabiliriz. Bu
                                    nedenle daha iyiye ulaşmak için fikirlerimizi cesurca söyler, birbirimizin
                                    görüşlerini yapıcı bir şekilde sorgularız.<br />• İnsana ve çevreye değer veririz.
                                    Güçlü yan haklar ve kulüpler ile sosyal hayatımızın desteklendiğini bilir, sosyal
                                    sorumluluk projeleriyle iyilik peşinde koşarız.</p>
                                <p>Çünkü Borusan Burada!<br />İşe Alım Süreci Nasıl İşleyecek?<br />Aklına takılan tüm
                                    sorular için cevaplar burada!</p>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <img src="Uploads/testmail/images/index_03.png" width="640" height="130" alt=""></td>
                        </tr>
                        <tr>
                            <td>
                                <img src="Uploads/testmail/images/index_04.png" width="640" height="1" alt=""></td>
                        </tr>
                        <tr>
                            <td>
                                <table id="Table_01" width="640" height="99" border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td>
                                            <img src="Uploads/testmail/images/social_01.png" width="297" height="99"
                                                alt=""></td>
                                        <td>
                                            <img src="Uploads/testmail/images/social_02.png" width="47" height="99"
                                                alt=""></td>
                                        <td>
                                            <img src="Uploads/testmail/images/social_03.png" width="296" height="99"
                                                alt=""></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </center>', 2, 1, 1, 1, 1, 1, CAST(N'2019-12-09 18:02:36.510' AS DateTime), NULL, 1, 0, 1)
INSERT [dbo].[Content] ([ContentID], [ContentName], [ContentDescription], [ContentHTML], [ContentLanguageID], [ContentCompanyID], [ContentRoleID], [ContentGalleryID], [ContentTemplateID], [ContentCategoryID], [ContentEntranceDate], [ContentUpdateDate], [ContentEnterBy], [ContentIsDraft], [ContentIsActive]) VALUES (3, N'Genel Duyurular', N'', N' <center>             <table bgcolor=''white'' width=''640'' height='''' border=''0'' cellpadding=''0'' cellspacing=''0'' align=''center''>
                        <tbody><tr>
                            <td>
                                <img src=''Uploads/testmail/images/index_01.png'' width=''640'' height=''396'' alt=''''></td>
                        </tr>
                        <tr>
                            <td style=''font-family: Arial; font-size: 15px; line-height: 22px; color: #333; padding: 40px;''>
                                <h1>Welcome to Borusan!</h1>
                                <br>
                                <p>We Borusans <span contenteditable=''''>27.05.2019</span> 
                                    <span contenteditable=''''>Nida Nur Küçük</span> joined us on the even more powerful. 
									We look forward to working together and adding new values to our values.</p>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <img src=''Uploads/testmail/images/index_03.png'' width=''640'' height=''130'' alt=''''></td>
                        </tr>
                        <tr>
                            <td>
                                <img src=''Uploads/testmail/images/index_04.png'' width=''640'' height=''1'' alt=''''></td>
                        </tr>
                        <tr>
                            <td>
                                <table id=''Table_01'' width=''640'' height=''99'' border=''0'' cellpadding=''0'' cellspacing=''0''>
                                    <tbody><tr>
                                        <td>
                                            <img src=''Uploads/testmail/images/social_01.png'' width=''297'' height=''99'' alt=''''></td>
                                        <td>
                                            <img src=''Uploads/testmail/images/social_02.png'' width=''47'' height=''99'' alt=''''></td>
                                        <td>
                                            <img src=''Uploads/testmail/images/social_03.png'' width=''296'' height=''99'' alt=''''></td>
                                    </tr>
                                </tbody></table>
                            </td>
                        </tr>
                    </tbody></table>
                </center>', 1, 1, 0, 0, 0, 2, CAST(N'2019-12-09 22:25:24.627' AS DateTime), NULL, 1, 0, 1)
INSERT [dbo].[Content] ([ContentID], [ContentName], [ContentDescription], [ContentHTML], [ContentLanguageID], [ContentCompanyID], [ContentRoleID], [ContentGalleryID], [ContentTemplateID], [ContentCategoryID], [ContentEntranceDate], [ContentUpdateDate], [ContentEnterBy], [ContentIsDraft], [ContentIsActive]) VALUES (4, N'Borusan Insan', NULL, N'      <center>', 1, 1, 1, 1, 1, 3, CAST(N'2019-12-09 22:25:24.627' AS DateTime), NULL, 1, 0, 1)
INSERT [dbo].[Content] ([ContentID], [ContentName], [ContentDescription], [ContentHTML], [ContentLanguageID], [ContentCompanyID], [ContentRoleID], [ContentGalleryID], [ContentTemplateID], [ContentCategoryID], [ContentEntranceDate], [ContentUpdateDate], [ContentEnterBy], [ContentIsDraft], [ContentIsActive]) VALUES (5, N'Yasam İnsan', N'1', N'1', 1, 1, 1, 1, 1, 4, CAST(N'2019-12-09 22:25:24.627' AS DateTime), NULL, 1, 0, 1)
SET IDENTITY_INSERT [dbo].[Content] OFF
SET IDENTITY_INSERT [dbo].[ContentCategory] ON 

INSERT [dbo].[ContentCategory] ([ContentCategoryID], [MainContentCategoryID], [ContentCategoryName], [ContentCategoryLogo], [ContentCategoryIsActive]) VALUES (1, 1, N'Borusan İnsan', N'Content/images/duyurular.svg', 1)
INSERT [dbo].[ContentCategory] ([ContentCategoryID], [MainContentCategoryID], [ContentCategoryName], [ContentCategoryLogo], [ContentCategoryIsActive]) VALUES (2, 2, N'Yaşam Burada', N'Content/images/duyurular.svg', 1)
INSERT [dbo].[ContentCategory] ([ContentCategoryID], [MainContentCategoryID], [ContentCategoryName], [ContentCategoryLogo], [ContentCategoryIsActive]) VALUES (3, 2, N'Kariyer Burada', N'Content/images/duyurular.svg', 1)
INSERT [dbo].[ContentCategory] ([ContentCategoryID], [MainContentCategoryID], [ContentCategoryName], [ContentCategoryLogo], [ContentCategoryIsActive]) VALUES (4, 2, N'Gelişim Burada', N'Content/images/duyurular.svg', 1)
INSERT [dbo].[ContentCategory] ([ContentCategoryID], [MainContentCategoryID], [ContentCategoryName], [ContentCategoryLogo], [ContentCategoryIsActive]) VALUES (5, 1, N'İş İlanları', N'Content/images/isilanlari.svg', 1)
SET IDENTITY_INSERT [dbo].[ContentCategory] OFF
SET IDENTITY_INSERT [dbo].[Department] ON 

INSERT [dbo].[Department] ([DepartmentID], [DepartmentName], [DepartmentIsActive]) VALUES (1, N'İnsan Kaynakları', 1)
INSERT [dbo].[Department] ([DepartmentID], [DepartmentName], [DepartmentIsActive]) VALUES (2, N'Satın Alma', 1)
SET IDENTITY_INSERT [dbo].[Department] OFF
SET IDENTITY_INSERT [dbo].[Gallery] ON 

INSERT [dbo].[Gallery] ([GalleryID], [CompanyID], [GalleryFolder], [GalleryIsActive]) VALUES (1, NULL, N'http://via.placeholder.com/420x200', 1)
INSERT [dbo].[Gallery] ([GalleryID], [CompanyID], [GalleryFolder], [GalleryIsActive]) VALUES (2, 1, N'Uploads/testmail/images/index_01.png', 1)
INSERT [dbo].[Gallery] ([GalleryID], [CompanyID], [GalleryFolder], [GalleryIsActive]) VALUES (3, 2, N'Uploads/testmail/images/index_02.png', 1)
INSERT [dbo].[Gallery] ([GalleryID], [CompanyID], [GalleryFolder], [GalleryIsActive]) VALUES (4, 3, N'Uploads/testmail/images/index_03.png', 1)
INSERT [dbo].[Gallery] ([GalleryID], [CompanyID], [GalleryFolder], [GalleryIsActive]) VALUES (5, 4, N'Uploads/testmail/images/index_04.png', 1)
INSERT [dbo].[Gallery] ([GalleryID], [CompanyID], [GalleryFolder], [GalleryIsActive]) VALUES (6, NULL, N'http://via.placeholder.com/420x200', 1)
INSERT [dbo].[Gallery] ([GalleryID], [CompanyID], [GalleryFolder], [GalleryIsActive]) VALUES (7, NULL, N'http://via.placeholder.com/420x200', 1)
INSERT [dbo].[Gallery] ([GalleryID], [CompanyID], [GalleryFolder], [GalleryIsActive]) VALUES (8, NULL, N'http://via.placeholder.com/420x200', 1)
INSERT [dbo].[Gallery] ([GalleryID], [CompanyID], [GalleryFolder], [GalleryIsActive]) VALUES (9, 1, N'/Content/Images/a59ef4d6-f685-45b5-8cc8-6c037ce23c28.jpg', 1)
INSERT [dbo].[Gallery] ([GalleryID], [CompanyID], [GalleryFolder], [GalleryIsActive]) VALUES (10, 0, N'/Content/Images/e1430331-d7ea-4369-9aa5-13b14b165351.jpg', 1)
INSERT [dbo].[Gallery] ([GalleryID], [CompanyID], [GalleryFolder], [GalleryIsActive]) VALUES (11, 4, N'/Content/Images/f8506451-d8a8-4241-bc00-22e80f755578.jpg', 1)
INSERT [dbo].[Gallery] ([GalleryID], [CompanyID], [GalleryFolder], [GalleryIsActive]) VALUES (12, 0, N'/Content/Images/e2ae357b-e6ec-4bb8-a409-89b1aef19b81.jpg', 1)
SET IDENTITY_INSERT [dbo].[Gallery] OFF
SET IDENTITY_INSERT [dbo].[GalleryContentCategory] ON 

INSERT [dbo].[GalleryContentCategory] ([GalleryContentCategoryID], [GalleryID], [ContentCategoryID], [GalleryContentCategoryIsActive]) VALUES (1, 1, 0, 1)
INSERT [dbo].[GalleryContentCategory] ([GalleryContentCategoryID], [GalleryID], [ContentCategoryID], [GalleryContentCategoryIsActive]) VALUES (2, 2, 0, 1)
INSERT [dbo].[GalleryContentCategory] ([GalleryContentCategoryID], [GalleryID], [ContentCategoryID], [GalleryContentCategoryIsActive]) VALUES (3, 3, 0, 1)
INSERT [dbo].[GalleryContentCategory] ([GalleryContentCategoryID], [GalleryID], [ContentCategoryID], [GalleryContentCategoryIsActive]) VALUES (4, 4, 0, 1)
INSERT [dbo].[GalleryContentCategory] ([GalleryContentCategoryID], [GalleryID], [ContentCategoryID], [GalleryContentCategoryIsActive]) VALUES (5, 5, 0, 1)
INSERT [dbo].[GalleryContentCategory] ([GalleryContentCategoryID], [GalleryID], [ContentCategoryID], [GalleryContentCategoryIsActive]) VALUES (6, 6, 0, 1)
INSERT [dbo].[GalleryContentCategory] ([GalleryContentCategoryID], [GalleryID], [ContentCategoryID], [GalleryContentCategoryIsActive]) VALUES (7, 7, 0, 1)
INSERT [dbo].[GalleryContentCategory] ([GalleryContentCategoryID], [GalleryID], [ContentCategoryID], [GalleryContentCategoryIsActive]) VALUES (8, 8, 0, 1)
INSERT [dbo].[GalleryContentCategory] ([GalleryContentCategoryID], [GalleryID], [ContentCategoryID], [GalleryContentCategoryIsActive]) VALUES (9, 9, 0, 1)
INSERT [dbo].[GalleryContentCategory] ([GalleryContentCategoryID], [GalleryID], [ContentCategoryID], [GalleryContentCategoryIsActive]) VALUES (10, 10, 0, 1)
INSERT [dbo].[GalleryContentCategory] ([GalleryContentCategoryID], [GalleryID], [ContentCategoryID], [GalleryContentCategoryIsActive]) VALUES (11, 11, 0, 1)
INSERT [dbo].[GalleryContentCategory] ([GalleryContentCategoryID], [GalleryID], [ContentCategoryID], [GalleryContentCategoryIsActive]) VALUES (12, 12, 0, 1)
SET IDENTITY_INSERT [dbo].[GalleryContentCategory] OFF
SET IDENTITY_INSERT [dbo].[Language] ON 

INSERT [dbo].[Language] ([LanguageID], [LanguageCode], [LanguageName], [LanguageIsActive]) VALUES (1, N'TR', N'Türkçe', 1)
INSERT [dbo].[Language] ([LanguageID], [LanguageCode], [LanguageName], [LanguageIsActive]) VALUES (2, N'EN', N'English', 1)
SET IDENTITY_INSERT [dbo].[Language] OFF
SET IDENTITY_INSERT [dbo].[MainContentCategory] ON 

INSERT [dbo].[MainContentCategory] ([MainContentCategoryID], [MainContentCategoryName]) VALUES (1, N'Genel Duyurular')
INSERT [dbo].[MainContentCategory] ([MainContentCategoryID], [MainContentCategoryName]) VALUES (2, N'İş İlanları')
SET IDENTITY_INSERT [dbo].[MainContentCategory] OFF
SET IDENTITY_INSERT [dbo].[Member] ON 

INSERT [dbo].[Member] ([MemberID], [MemberName], [MemberSurname], [MemberEMail], [MemberPhone], [MemberPassword], [MemberGroupID], [MemberCompanyID], [MemberEntranceDate], [MemberActivatedDate], [MemberIsActive]) VALUES (1, N'METEHAN', N'YILDIZAY', N'myildizay@hotmail.com', N'(212) 211-1134', N'57LW2ifmzHQBclmuXHuJ0g==', 1, 1, CAST(N'2019-11-11 09:07:43.110' AS DateTime), CAST(N'2019-11-11 09:22:53.800' AS DateTime), 1)
INSERT [dbo].[Member] ([MemberID], [MemberName], [MemberSurname], [MemberEMail], [MemberPhone], [MemberPassword], [MemberGroupID], [MemberCompanyID], [MemberEntranceDate], [MemberActivatedDate], [MemberIsActive]) VALUES (2, N'Dünya', N'YAVAŞ', N'dunya.yavas@rhinorunner.com', N'', N'PyX7xKc7in+WUGgTVCKyeg==', 1, 1, CAST(N'2019-11-11 09:08:18.360' AS DateTime), CAST(N'2019-11-11 09:23:04.467' AS DateTime), 1)
INSERT [dbo].[Member] ([MemberID], [MemberName], [MemberSurname], [MemberEMail], [MemberPhone], [MemberPassword], [MemberGroupID], [MemberCompanyID], [MemberEntranceDate], [MemberActivatedDate], [MemberIsActive]) VALUES (3, N'Özkan', N'Özsert', N'ozkan.ozsert@rhinorunner.com', N'', N'PyX7xKc7in+WUGgTVCKyeg==', 1, 1, CAST(N'2019-11-11 09:09:00.843' AS DateTime), CAST(N'2019-11-11 09:23:06.657' AS DateTime), 1)
INSERT [dbo].[Member] ([MemberID], [MemberName], [MemberSurname], [MemberEMail], [MemberPhone], [MemberPassword], [MemberGroupID], [MemberCompanyID], [MemberEntranceDate], [MemberActivatedDate], [MemberIsActive]) VALUES (4, N'Mehmet', N'Emin Türkmen', N'mehmetemin.turkmen@emekisbilisim.com', N'', N'7Cfy2dr+aG2kd9+G7A82sA==', 2, 3, CAST(N'2019-11-11 09:09:50.573' AS DateTime), CAST(N'2019-11-11 09:23:12.750' AS DateTime), 0)
INSERT [dbo].[Member] ([MemberID], [MemberName], [MemberSurname], [MemberEMail], [MemberPhone], [MemberPassword], [MemberGroupID], [MemberCompanyID], [MemberEntranceDate], [MemberActivatedDate], [MemberIsActive]) VALUES (5, N'Emrah', N'KAÇMAZ', N'ekacmaz@gmail.com', N'(532) 694-5216', N'2X+0D10YXptfGF/J2td/5T0nF9pl2/gAMqfnml0/kSss8Tt8jMOMYa3wpk+ZtdK1', 2, 1, CAST(N'2019-11-11 09:15:00.417' AS DateTime), NULL, 0)
INSERT [dbo].[Member] ([MemberID], [MemberName], [MemberSurname], [MemberEMail], [MemberPhone], [MemberPassword], [MemberGroupID], [MemberCompanyID], [MemberEntranceDate], [MemberActivatedDate], [MemberIsActive]) VALUES (6, N'Admin', N'Admin', N'admin', N'', N'wUDcU+0usRy4SqHD8a0cmg==', 2, 1, CAST(N'2019-11-11 10:57:22.747' AS DateTime), NULL, 1)
INSERT [dbo].[Member] ([MemberID], [MemberName], [MemberSurname], [MemberEMail], [MemberPhone], [MemberPassword], [MemberGroupID], [MemberCompanyID], [MemberEntranceDate], [MemberActivatedDate], [MemberIsActive]) VALUES (7, N'Metehan', N'YILDIZAY', N'myildizay@hotmail.com', N'(021) 222-2222', N'8ZZjpEQZB2S+pTjI2ngCS0iYeGrKuxBd54bfQi5BYzA=', 2, 1, CAST(N'2019-11-11 14:13:42.913' AS DateTime), NULL, 0)
SET IDENTITY_INSERT [dbo].[Member] OFF
SET IDENTITY_INSERT [dbo].[MemberGroup] ON 

INSERT [dbo].[MemberGroup] ([MemberGroupID], [MemberGroupName]) VALUES (1, N'Admin')
INSERT [dbo].[MemberGroup] ([MemberGroupID], [MemberGroupName]) VALUES (2, N'Firma Admin')
INSERT [dbo].[MemberGroup] ([MemberGroupID], [MemberGroupName]) VALUES (3, N'Kullanıcı')
SET IDENTITY_INSERT [dbo].[MemberGroup] OFF
SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([RoleID], [RoleName], [RoleOpenningTextTR], [RoleClosingTextTR], [RoleOpenningTextEN], [RoleClosingTextEN], [RoleIsActive]) VALUES (1, N'Digital', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[Role] ([RoleID], [RoleName], [RoleOpenningTextTR], [RoleClosingTextTR], [RoleOpenningTextEN], [RoleClosingTextEN], [RoleIsActive]) VALUES (2, N'IK', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[Role] ([RoleID], [RoleName], [RoleOpenningTextTR], [RoleClosingTextTR], [RoleOpenningTextEN], [RoleClosingTextEN], [RoleIsActive]) VALUES (3, N'Role1', N'dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry
                                                          
                                                        ', N'dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry
                                                          

                                                        ', N'dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry
                                                            
                                                        ', N'dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry
                                                           

                                                        ', 1)
SET IDENTITY_INSERT [dbo].[Role] OFF
SET IDENTITY_INSERT [dbo].[SampleContent] ON 

INSERT [dbo].[SampleContent] ([SampleContentID], [SampleContentName], [SampleContentLanguageID], [SampleContentCategoryID], [SampleContentHTML], [SampleContentEntranceDate], [SampleContentIsActive]) VALUES (1, N'Borusan İnsan', 1, 1, N'<center>
                    <table bgcolor="white"  width="640" height="" border="0" cellpadding="0"
                        cellspacing="0" align="center">
                        <tr>
                            <td>
                                <img src="Uploads/testmail/images/index_01.png" width="640" height="396" alt=""></td>
                        </tr>
                        <tr>
                            <td
                                style="font-family: Arial; font-size: 15px; line-height: 22px; color: #333; padding: 40px;">
                                <h1>Türkiye''nin geleceğini inşa ediyoruz.</h1>
								<h2><span contenteditable="" class="companyName"></span> İnsan</h2>
                                <br>
                                <p>Avrupa’nın önde gelen çelik boru üreticilerinden biri olan <span contenteditable="" class="companyName"></span>’da
                                    yaşam kalitesini yükselten ürün ve hizmetler sunmak ve toplumun ekonomik, sosyal
                                    gelişimini üst seviyelere taşımak için <span contenteditable="" id="roleName"></span>
                                    olarak çalışacak ekip arkadaşları arıyoruz.</p>
                                <p>Eğer sen de dinamik bir ortamda, harika takım arkadaşlarıyla zorlu işlerin üstesinden
                                    gelmek istiyorsan, <span contenteditable="" class="companyName"></span></p>
								
                                <p>Biz <span contenteditable="" class="companyName"></span> olarak,</p></span>
								<span contenteditable="" id="companyOpenningText">
								<p><span contenteditable="" id="softskillName"></span></span>
                                
                                <p><span contenteditable="" id="softskillName"></span></p>
								<p><span contenteditable="" id="companyClosingText"></span></p>
                               
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <img src="Uploads/testmail/images/index_03.png" width="640" height="130" alt=""></td>
                        </tr>
                        <tr>
                            <td>
                                <img src="Uploads/testmail/images/index_04.png" width="640" height="1" alt=""></td>
                        </tr>
                        <tr>
                            <td>
                                <table id="Table_01" width="640" height="99" border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td>
                                            <img src="Uploads/testmail/images/social_01.png" width="297" height="99"
                                                alt=""></td>
                                        <td>
                                            <img src="Uploads/testmail/images/social_02.png" width="47" height="99"
                                                alt=""></td>
                                        <td>
                                            <img src="Uploads/testmail/images/social_03.png" width="296" height="99"
                                                alt=""></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </center>', CAST(N'2019-12-13 20:59:34.183' AS DateTime), 1)
INSERT [dbo].[SampleContent] ([SampleContentID], [SampleContentName], [SampleContentLanguageID], [SampleContentCategoryID], [SampleContentHTML], [SampleContentEntranceDate], [SampleContentIsActive]) VALUES (2, N'Yaşam Burada', 1, 2, N'<center>
                    <table bgcolor="white"  width="640" height="" border="0" cellpadding="0"
                        cellspacing="0" align="center">
                        <tr>
                            <td>
                                <img src="Uploads/testmail/images/index_01.png" width="640" height="396" alt=""></td>
                        </tr>
                        <tr>
                            <td
                                style="font-family: Arial; font-size: 15px; line-height: 22px; color: #333; padding: 40px;">
                                <h1>Türkiye''nin geleceğini inşa ediyoruz.</h1>
								<h2>Yaşam Burada</h2>
                                <br>
                                <p>Avrupa’nın önde gelen çelik boru üreticilerinden biri olan <span contenteditable="" id="company">Borusan Mannesmann Boru</span>’da
                                    yaşam kalitesini yükselten ürün ve hizmetler sunmak ve toplumun ekonomik, sosyal
                                    gelişimini üst seviyelere taşımak için <span contenteditable="">«Elektrik Bakım ve Otomasyon Mühendisi»</span>
                                    olarak çalışacak ekip arkadaşları arıyoruz.</p>
                                <p>Eğer sen de dinamik bir ortamda, harika takım arkadaşlarıyla zorlu işlerin üstesinden
                                    gelmek istiyorsan, Borusan Burada.</p>
                                <p>Biz Borusan Mannesmann Boru olarak, 4.000 çeşit ürünümüzle başta inşaat, enerji ve
                                    otomotiv olmak üzere pek çok sektöre hizmet veriyor, İstanbul Sanayi Odası 500 (ISO
                                    500) endeksinde 49. sırada yer alıyoruz. Türkiye’de de pazar lideri konumunda, 1500
                                    kişilik işgücü ve 1,4 milyon tonluk çelik boru üretim kapasitemizle; su boruları,
                                    gaz boruları, genel amaçlı borular, doğal gaz ve petrol hat boruları, sanayi boru ve
                                    profilleri, sondaj boruları ve güçlendirilmiş çelik yapı profilleri üretiyor,
                                    müşterilerimizin ve ülkemizin yaşam kalitesini artırmayı amaçlıyoruz.</p>
                                <p><strong>Senden Neler Bekliyoruz?</strong><br />Gerçek mühendislik sorunları ile ilgilenip işini en iyi
                                    şekilde yapman için ileri teknolojiye sahip fırsatlar sunuyoruz. Tüm bunları
                                    yaparken senden beklediklerimiz:</p>
                                <p><span contenteditable="" id="role">• Mevcut hatlardaki arızaları tespit etmen ve ilgilenecek ekibi
                                        yönlendirmeni,<br />Planlı bakım programlarını hazırlanmasını, güncellenmesini ve
                                        bakımların gerçekleştirilmesini sağlaman,<br />• Yeni kurulacak hatlarda yüklenici
                                        firmalarla elektrik ve otomasyon işleri konusunda iletişimi yürütülüp şirket
                                        yükümlülüklerinin yapılması için gerekli aksiyonları planlanıp yerine
                                        getirmen,<br />• Öz kaynaklarla yapılan projelerin elektriksel şemalarını
                                        tasarlaman, gerekli malzemelerin seçimini yapman ve PLC programını yazılıp sistemi
                                        devreye alman,<br />• Otomasyon sektöründe gelişmeleri takip etmen ve mevcut
                                        işleyişi geliştirmek için bunları var olan uygulamalara uyarlaman,<br />• İç
                                        müşterilerin ihtiyaçları doğrultusunda otomasyon projelerini geliştirilip bunu iç ya
                                        da dış kaynaklarla yürütülmesini organize etmen.</span></p>
                                <p><span contenteditable="" id="softskill"><strong>Neden sen?</strong><br />• Üniversitelerin Elektrik, Elektronik, Mekatronik, Kontrol ve
                                    Otomasyon bölümlerinden mezunuysan,<br />• En az bir programlama diline hâkimsen ve
                                    algoritma geliştirebiliyorsan,<br />• Yoğun iş temposuna ayak
                                    uydurabiliyorsan,<br />• İş süreçlerinde kullanmak için iyi derecede İngilizce
                                    biliyorsan,<br />• Tercihen PLC, sürücüler, HMI''lar ve diğer endüstriyel ekipmanlar
                                    ile uygulamalar yapıp devreye alıyor, otomasyon kontrol panoları tasarlıyor,
                                    imalatını yapıyor ya da katkıda bulunuyorsan,<br />• Şema çizim programlarını
                                    kullanabiliyorsan,</span></p>
                                <p><span contenteditable="">Aradığımız kişi sen olabilirsin.</span></p>
                                <p><strong>Öne çıkmak için neye ihtiyacın var?</strong> <br />• Kendini ve işini sürekli güncelleyebilmen
                                    için yenilikçi ve araştırmacı bir ruha sahip olmalısın.<br />• Gerekli durumlarda
                                    ekibe koçluk edip, doğru zamanda doğru yerde olmalarını sağlamalısın.<br />• Zorlu
                                    durumlar ve kişiler ile başa çıkabilecek ikna yeteneğine sahip olmalısın. <br />∙
                                    Kriz durumlarında oluşabilecek stresi iyi yönetebilmeli, kritik anlarda bile çözüm
                                    odaklı olmalısın. <br />• Doğru organizasyon ve planlama ile zaman yönetimini en
                                    verimli şekilde kullanmalısın.</p>
                                <p><strong>Borusan’da biz:</strong><br />• Kendimizi geliştirmek için işimizi geliştirir; yeni bilgi ve
                                    beceriler edinerek, yeni sorumluluklar üstleniriz. Bilgiye karşı her zaman merak
                                    duyar, araştırır; yaşam boyu öğrenmenin gücüne inanırız.<br />• Gelecek için ortak
                                    hayaller kurar, hayallerimizi hayata geçirirken önceliklerimizi doğru belirler,
                                    çeviklikle harekete geçeriz. Pazarı, teknolojiyi, trendleri ve rakipleri yakından
                                    takip eder; pazardaki fırsatları en iyi şekilde değerlendirerek fark yaratırız. Her
                                    zaman işimizi daha iyi yapmanın yollarını ararız.<br />• Biliriz ki başarıya ancak
                                    açık ve şeffaf iletişim kuran, ortak akılla hareket eden takımlarla ulaşabiliriz. Bu
                                    nedenle daha iyiye ulaşmak için fikirlerimizi cesurca söyler, birbirimizin
                                    görüşlerini yapıcı bir şekilde sorgularız.<br />• İnsana ve çevreye değer veririz.
                                    Güçlü yan haklar ve kulüpler ile sosyal hayatımızın desteklendiğini bilir, sosyal
                                    sorumluluk projeleriyle iyilik peşinde koşarız.</p>
                                <p>Çünkü Borusan Burada!<br />İşe Alım Süreci Nasıl İşleyecek?<br />Aklına takılan tüm
                                    sorular için cevaplar burada!</p>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <img src="Uploads/testmail/images/index_03.png" width="640" height="130" alt=""></td>
                        </tr>
                        <tr>
                            <td>
                                <img src="Uploads/testmail/images/index_04.png" width="640" height="1" alt=""></td>
                        </tr>
                        <tr>
                            <td>
                                <table id="Table_01" width="640" height="99" border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td>
                                            <img src="Uploads/testmail/images/social_01.png" width="297" height="99"
                                                alt=""></td>
                                        <td>
                                            <img src="Uploads/testmail/images/social_02.png" width="47" height="99"
                                                alt=""></td>
                                        <td>
                                            <img src="Uploads/testmail/images/social_03.png" width="296" height="99"
                                                alt=""></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </center>', CAST(N'2019-12-13 20:59:34.183' AS DateTime), 1)
INSERT [dbo].[SampleContent] ([SampleContentID], [SampleContentName], [SampleContentLanguageID], [SampleContentCategoryID], [SampleContentHTML], [SampleContentEntranceDate], [SampleContentIsActive]) VALUES (3, N'Kariyer Burada', 1, 3, N'<center>
                    <table bgcolor="white"  width="640" height="" border="0" cellpadding="0"
                        cellspacing="0" align="center">
                        <tr>
                            <td>
                                <img src="Uploads/testmail/images/index_01.png" width="640" height="396" alt=""></td>
                        </tr>
                        <tr>
                            <td
                                style="font-family: Arial; font-size: 15px; line-height: 22px; color: #333; padding: 40px;">
                                <h1>Türkiye''nin geleceğini inşa ediyoruz.</h1>
								<h2>Kariyer Burada</h2>
                                <br>
                                <p>Avrupa’nın önde gelen çelik boru üreticilerinden biri olan <span contenteditable="" id="company">Borusan Mannesmann Boru</span>’da
                                    yaşam kalitesini yükselten ürün ve hizmetler sunmak ve toplumun ekonomik, sosyal
                                    gelişimini üst seviyelere taşımak için <span contenteditable="">«Elektrik Bakım ve Otomasyon Mühendisi»</span>
                                    olarak çalışacak ekip arkadaşları arıyoruz.</p>
                                <p>Eğer sen de dinamik bir ortamda, harika takım arkadaşlarıyla zorlu işlerin üstesinden
                                    gelmek istiyorsan, Borusan Burada.</p>
                                <p>Biz Borusan Mannesmann Boru olarak, 4.000 çeşit ürünümüzle başta inşaat, enerji ve
                                    otomotiv olmak üzere pek çok sektöre hizmet veriyor, İstanbul Sanayi Odası 500 (ISO
                                    500) endeksinde 49. sırada yer alıyoruz. Türkiye’de de pazar lideri konumunda, 1500
                                    kişilik işgücü ve 1,4 milyon tonluk çelik boru üretim kapasitemizle; su boruları,
                                    gaz boruları, genel amaçlı borular, doğal gaz ve petrol hat boruları, sanayi boru ve
                                    profilleri, sondaj boruları ve güçlendirilmiş çelik yapı profilleri üretiyor,
                                    müşterilerimizin ve ülkemizin yaşam kalitesini artırmayı amaçlıyoruz.</p>
                                <p><strong>Senden Neler Bekliyoruz?</strong><br />Gerçek mühendislik sorunları ile ilgilenip işini en iyi
                                    şekilde yapman için ileri teknolojiye sahip fırsatlar sunuyoruz. Tüm bunları
                                    yaparken senden beklediklerimiz:</p>
                                <p><span contenteditable="" id="role">• Mevcut hatlardaki arızaları tespit etmen ve ilgilenecek ekibi
                                        yönlendirmeni,<br />Planlı bakım programlarını hazırlanmasını, güncellenmesini ve
                                        bakımların gerçekleştirilmesini sağlaman,<br />• Yeni kurulacak hatlarda yüklenici
                                        firmalarla elektrik ve otomasyon işleri konusunda iletişimi yürütülüp şirket
                                        yükümlülüklerinin yapılması için gerekli aksiyonları planlanıp yerine
                                        getirmen,<br />• Öz kaynaklarla yapılan projelerin elektriksel şemalarını
                                        tasarlaman, gerekli malzemelerin seçimini yapman ve PLC programını yazılıp sistemi
                                        devreye alman,<br />• Otomasyon sektöründe gelişmeleri takip etmen ve mevcut
                                        işleyişi geliştirmek için bunları var olan uygulamalara uyarlaman,<br />• İç
                                        müşterilerin ihtiyaçları doğrultusunda otomasyon projelerini geliştirilip bunu iç ya
                                        da dış kaynaklarla yürütülmesini organize etmen.</span></p>
                                <p><span contenteditable="" id="softskill"><strong>Neden sen?</strong><br />• Üniversitelerin Elektrik, Elektronik, Mekatronik, Kontrol ve
                                    Otomasyon bölümlerinden mezunuysan,<br />• En az bir programlama diline hâkimsen ve
                                    algoritma geliştirebiliyorsan,<br />• Yoğun iş temposuna ayak
                                    uydurabiliyorsan,<br />• İş süreçlerinde kullanmak için iyi derecede İngilizce
                                    biliyorsan,<br />• Tercihen PLC, sürücüler, HMI''lar ve diğer endüstriyel ekipmanlar
                                    ile uygulamalar yapıp devreye alıyor, otomasyon kontrol panoları tasarlıyor,
                                    imalatını yapıyor ya da katkıda bulunuyorsan,<br />• Şema çizim programlarını
                                    kullanabiliyorsan,</span></p>
                                <p><span contenteditable="">Aradığımız kişi sen olabilirsin.</span></p>
                                <p><strong>Öne çıkmak için neye ihtiyacın var?</strong> <br />• Kendini ve işini sürekli güncelleyebilmen
                                    için yenilikçi ve araştırmacı bir ruha sahip olmalısın.<br />• Gerekli durumlarda
                                    ekibe koçluk edip, doğru zamanda doğru yerde olmalarını sağlamalısın.<br />• Zorlu
                                    durumlar ve kişiler ile başa çıkabilecek ikna yeteneğine sahip olmalısın. <br />∙
                                    Kriz durumlarında oluşabilecek stresi iyi yönetebilmeli, kritik anlarda bile çözüm
                                    odaklı olmalısın. <br />• Doğru organizasyon ve planlama ile zaman yönetimini en
                                    verimli şekilde kullanmalısın.</p>
                                <p><strong>Borusan’da biz:</strong><br />• Kendimizi geliştirmek için işimizi geliştirir; yeni bilgi ve
                                    beceriler edinerek, yeni sorumluluklar üstleniriz. Bilgiye karşı her zaman merak
                                    duyar, araştırır; yaşam boyu öğrenmenin gücüne inanırız.<br />• Gelecek için ortak
                                    hayaller kurar, hayallerimizi hayata geçirirken önceliklerimizi doğru belirler,
                                    çeviklikle harekete geçeriz. Pazarı, teknolojiyi, trendleri ve rakipleri yakından
                                    takip eder; pazardaki fırsatları en iyi şekilde değerlendirerek fark yaratırız. Her
                                    zaman işimizi daha iyi yapmanın yollarını ararız.<br />• Biliriz ki başarıya ancak
                                    açık ve şeffaf iletişim kuran, ortak akılla hareket eden takımlarla ulaşabiliriz. Bu
                                    nedenle daha iyiye ulaşmak için fikirlerimizi cesurca söyler, birbirimizin
                                    görüşlerini yapıcı bir şekilde sorgularız.<br />• İnsana ve çevreye değer veririz.
                                    Güçlü yan haklar ve kulüpler ile sosyal hayatımızın desteklendiğini bilir, sosyal
                                    sorumluluk projeleriyle iyilik peşinde koşarız.</p>
                                <p>Çünkü Borusan Burada!<br />İşe Alım Süreci Nasıl İşleyecek?<br />Aklına takılan tüm
                                    sorular için cevaplar burada!</p>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <img src="Uploads/testmail/images/index_03.png" width="640" height="130" alt=""></td>
                        </tr>
                        <tr>
                            <td>
                                <img src="Uploads/testmail/images/index_04.png" width="640" height="1" alt=""></td>
                        </tr>
                        <tr>
                            <td>
                                <table id="Table_01" width="640" height="99" border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td>
                                            <img src="Uploads/testmail/images/social_01.png" width="297" height="99"
                                                alt=""></td>
                                        <td>
                                            <img src="Uploads/testmail/images/social_02.png" width="47" height="99"
                                                alt=""></td>
                                        <td>
                                            <img src="Uploads/testmail/images/social_03.png" width="296" height="99"
                                                alt=""></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </center>', CAST(N'2019-12-13 20:59:34.183' AS DateTime), 1)
INSERT [dbo].[SampleContent] ([SampleContentID], [SampleContentName], [SampleContentLanguageID], [SampleContentCategoryID], [SampleContentHTML], [SampleContentEntranceDate], [SampleContentIsActive]) VALUES (4, N'Gelişim Burada', 1, 4, N'<center>
                    <table bgcolor="white"  width="640" height="" border="0" cellpadding="0"
                        cellspacing="0" align="center">
                        <tr>
                            <td>
                                <img src="Uploads/testmail/images/index_01.png" width="640" height="396" alt=""></td>
                        </tr>
                        <tr>
                            <td
                                style="font-family: Arial; font-size: 15px; line-height: 22px; color: #333; padding: 40px;">
                                <h1>Türkiye''nin geleceğini inşa ediyoruz.</h1>
								<h2>Gelişim Burada</h2>
                                <br>
                                <p>Avrupa’nın önde gelen çelik boru üreticilerinden biri olan <span contenteditable="" id="company">Borusan Mannesmann Boru</span>’da
                                    yaşam kalitesini yükselten ürün ve hizmetler sunmak ve toplumun ekonomik, sosyal
                                    gelişimini üst seviyelere taşımak için <span contenteditable="">«Elektrik Bakım ve Otomasyon Mühendisi»</span>
                                    olarak çalışacak ekip arkadaşları arıyoruz.</p>
                                <p>Eğer sen de dinamik bir ortamda, harika takım arkadaşlarıyla zorlu işlerin üstesinden
                                    gelmek istiyorsan, Borusan Burada.</p>
                                <p>Biz Borusan Mannesmann Boru olarak, 4.000 çeşit ürünümüzle başta inşaat, enerji ve
                                    otomotiv olmak üzere pek çok sektöre hizmet veriyor, İstanbul Sanayi Odası 500 (ISO
                                    500) endeksinde 49. sırada yer alıyoruz. Türkiye’de de pazar lideri konumunda, 1500
                                    kişilik işgücü ve 1,4 milyon tonluk çelik boru üretim kapasitemizle; su boruları,
                                    gaz boruları, genel amaçlı borular, doğal gaz ve petrol hat boruları, sanayi boru ve
                                    profilleri, sondaj boruları ve güçlendirilmiş çelik yapı profilleri üretiyor,
                                    müşterilerimizin ve ülkemizin yaşam kalitesini artırmayı amaçlıyoruz.</p>
                                <p><strong>Senden Neler Bekliyoruz?</strong><br />Gerçek mühendislik sorunları ile ilgilenip işini en iyi
                                    şekilde yapman için ileri teknolojiye sahip fırsatlar sunuyoruz. Tüm bunları
                                    yaparken senden beklediklerimiz:</p>
                                <p><span contenteditable="" id="role">• Mevcut hatlardaki arızaları tespit etmen ve ilgilenecek ekibi
                                        yönlendirmeni,<br />Planlı bakım programlarını hazırlanmasını, güncellenmesini ve
                                        bakımların gerçekleştirilmesini sağlaman,<br />• Yeni kurulacak hatlarda yüklenici
                                        firmalarla elektrik ve otomasyon işleri konusunda iletişimi yürütülüp şirket
                                        yükümlülüklerinin yapılması için gerekli aksiyonları planlanıp yerine
                                        getirmen,<br />• Öz kaynaklarla yapılan projelerin elektriksel şemalarını
                                        tasarlaman, gerekli malzemelerin seçimini yapman ve PLC programını yazılıp sistemi
                                        devreye alman,<br />• Otomasyon sektöründe gelişmeleri takip etmen ve mevcut
                                        işleyişi geliştirmek için bunları var olan uygulamalara uyarlaman,<br />• İç
                                        müşterilerin ihtiyaçları doğrultusunda otomasyon projelerini geliştirilip bunu iç ya
                                        da dış kaynaklarla yürütülmesini organize etmen.</span></p>
                                <p><span contenteditable="" id="softskill"><strong>Neden sen?</strong><br />• Üniversitelerin Elektrik, Elektronik, Mekatronik, Kontrol ve
                                    Otomasyon bölümlerinden mezunuysan,<br />• En az bir programlama diline hâkimsen ve
                                    algoritma geliştirebiliyorsan,<br />• Yoğun iş temposuna ayak
                                    uydurabiliyorsan,<br />• İş süreçlerinde kullanmak için iyi derecede İngilizce
                                    biliyorsan,<br />• Tercihen PLC, sürücüler, HMI''lar ve diğer endüstriyel ekipmanlar
                                    ile uygulamalar yapıp devreye alıyor, otomasyon kontrol panoları tasarlıyor,
                                    imalatını yapıyor ya da katkıda bulunuyorsan,<br />• Şema çizim programlarını
                                    kullanabiliyorsan,</span></p>
                                <p><span contenteditable="">Aradığımız kişi sen olabilirsin.</span></p>
                                <p><strong>Öne çıkmak için neye ihtiyacın var?</strong> <br />• Kendini ve işini sürekli güncelleyebilmen
                                    için yenilikçi ve araştırmacı bir ruha sahip olmalısın.<br />• Gerekli durumlarda
                                    ekibe koçluk edip, doğru zamanda doğru yerde olmalarını sağlamalısın.<br />• Zorlu
                                    durumlar ve kişiler ile başa çıkabilecek ikna yeteneğine sahip olmalısın. <br />∙
                                    Kriz durumlarında oluşabilecek stresi iyi yönetebilmeli, kritik anlarda bile çözüm
                                    odaklı olmalısın. <br />• Doğru organizasyon ve planlama ile zaman yönetimini en
                                    verimli şekilde kullanmalısın.</p>
                                <p><strong>Borusan’da biz:</strong><br />• Kendimizi geliştirmek için işimizi geliştirir; yeni bilgi ve
                                    beceriler edinerek, yeni sorumluluklar üstleniriz. Bilgiye karşı her zaman merak
                                    duyar, araştırır; yaşam boyu öğrenmenin gücüne inanırız.<br />• Gelecek için ortak
                                    hayaller kurar, hayallerimizi hayata geçirirken önceliklerimizi doğru belirler,
                                    çeviklikle harekete geçeriz. Pazarı, teknolojiyi, trendleri ve rakipleri yakından
                                    takip eder; pazardaki fırsatları en iyi şekilde değerlendirerek fark yaratırız. Her
                                    zaman işimizi daha iyi yapmanın yollarını ararız.<br />• Biliriz ki başarıya ancak
                                    açık ve şeffaf iletişim kuran, ortak akılla hareket eden takımlarla ulaşabiliriz. Bu
                                    nedenle daha iyiye ulaşmak için fikirlerimizi cesurca söyler, birbirimizin
                                    görüşlerini yapıcı bir şekilde sorgularız.<br />• İnsana ve çevreye değer veririz.
                                    Güçlü yan haklar ve kulüpler ile sosyal hayatımızın desteklendiğini bilir, sosyal
                                    sorumluluk projeleriyle iyilik peşinde koşarız.</p>
                                <p>Çünkü Borusan Burada!<br />İşe Alım Süreci Nasıl İşleyecek?<br />Aklına takılan tüm
                                    sorular için cevaplar burada!</p>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <img src="Uploads/testmail/images/index_03.png" width="640" height="130" alt=""></td>
                        </tr>
                        <tr>
                            <td>
                                <img src="Uploads/testmail/images/index_04.png" width="640" height="1" alt=""></td>
                        </tr>
                        <tr>
                            <td>
                                <table id="Table_01" width="640" height="99" border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td>
                                            <img src="Uploads/testmail/images/social_01.png" width="297" height="99"
                                                alt=""></td>
                                        <td>
                                            <img src="Uploads/testmail/images/social_02.png" width="47" height="99"
                                                alt=""></td>
                                        <td>
                                            <img src="Uploads/testmail/images/social_03.png" width="296" height="99"
                                                alt=""></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </center>', CAST(N'2019-12-13 20:59:34.183' AS DateTime), 1)
INSERT [dbo].[SampleContent] ([SampleContentID], [SampleContentName], [SampleContentLanguageID], [SampleContentCategoryID], [SampleContentHTML], [SampleContentEntranceDate], [SampleContentIsActive]) VALUES (5, N'İş İlanları', 1, 5, N'<center>
                    <table bgcolor="white"  width="640" height="" border="0" cellpadding="0"
                        cellspacing="0" align="center">
                        <tr>
                            <td>
                                <img src="Uploads/testmail/images/index_01.png" width="640" height="396" alt=""></td>
                        </tr>
                        <tr>
                            <td
                                style="font-family: Arial; font-size: 15px; line-height: 22px; color: #333; padding: 40px;">
                                <h1>Türkiye''nin geleceğini inşa ediyoruz.</h1>
								<h2>İş İlanları</h2>
                                <br>
                                <p>Avrupa’nın önde gelen çelik boru üreticilerinden biri olan <span contenteditable="" id="company">Borusan Mannesmann Boru</span>’da
                                    yaşam kalitesini yükselten ürün ve hizmetler sunmak ve toplumun ekonomik, sosyal
                                    gelişimini üst seviyelere taşımak için <span contenteditable="">«Elektrik Bakım ve Otomasyon Mühendisi»</span>
                                    olarak çalışacak ekip arkadaşları arıyoruz.</p>
                                <p>Eğer sen de dinamik bir ortamda, harika takım arkadaşlarıyla zorlu işlerin üstesinden
                                    gelmek istiyorsan, Borusan Burada.</p>
                                <p>Biz Borusan Mannesmann Boru olarak, 4.000 çeşit ürünümüzle başta inşaat, enerji ve
                                    otomotiv olmak üzere pek çok sektöre hizmet veriyor, İstanbul Sanayi Odası 500 (ISO
                                    500) endeksinde 49. sırada yer alıyoruz. Türkiye’de de pazar lideri konumunda, 1500
                                    kişilik işgücü ve 1,4 milyon tonluk çelik boru üretim kapasitemizle; su boruları,
                                    gaz boruları, genel amaçlı borular, doğal gaz ve petrol hat boruları, sanayi boru ve
                                    profilleri, sondaj boruları ve güçlendirilmiş çelik yapı profilleri üretiyor,
                                    müşterilerimizin ve ülkemizin yaşam kalitesini artırmayı amaçlıyoruz.</p>
                                <p><strong>Senden Neler Bekliyoruz?</strong><br />Gerçek mühendislik sorunları ile ilgilenip işini en iyi
                                    şekilde yapman için ileri teknolojiye sahip fırsatlar sunuyoruz. Tüm bunları
                                    yaparken senden beklediklerimiz:</p>
                                <p><span contenteditable="" id="role">• Mevcut hatlardaki arızaları tespit etmen ve ilgilenecek ekibi
                                        yönlendirmeni,<br />Planlı bakım programlarını hazırlanmasını, güncellenmesini ve
                                        bakımların gerçekleştirilmesini sağlaman,<br />• Yeni kurulacak hatlarda yüklenici
                                        firmalarla elektrik ve otomasyon işleri konusunda iletişimi yürütülüp şirket
                                        yükümlülüklerinin yapılması için gerekli aksiyonları planlanıp yerine
                                        getirmen,<br />• Öz kaynaklarla yapılan projelerin elektriksel şemalarını
                                        tasarlaman, gerekli malzemelerin seçimini yapman ve PLC programını yazılıp sistemi
                                        devreye alman,<br />• Otomasyon sektöründe gelişmeleri takip etmen ve mevcut
                                        işleyişi geliştirmek için bunları var olan uygulamalara uyarlaman,<br />• İç
                                        müşterilerin ihtiyaçları doğrultusunda otomasyon projelerini geliştirilip bunu iç ya
                                        da dış kaynaklarla yürütülmesini organize etmen.</span></p>
                                <p><span contenteditable="" id="softskill"><strong>Neden sen?</strong><br />• Üniversitelerin Elektrik, Elektronik, Mekatronik, Kontrol ve
                                    Otomasyon bölümlerinden mezunuysan,<br />• En az bir programlama diline hâkimsen ve
                                    algoritma geliştirebiliyorsan,<br />• Yoğun iş temposuna ayak
                                    uydurabiliyorsan,<br />• İş süreçlerinde kullanmak için iyi derecede İngilizce
                                    biliyorsan,<br />• Tercihen PLC, sürücüler, HMI''lar ve diğer endüstriyel ekipmanlar
                                    ile uygulamalar yapıp devreye alıyor, otomasyon kontrol panoları tasarlıyor,
                                    imalatını yapıyor ya da katkıda bulunuyorsan,<br />• Şema çizim programlarını
                                    kullanabiliyorsan,</span></p>
                                <p><span contenteditable="">Aradığımız kişi sen olabilirsin.</span></p>
                                <p><strong>Öne çıkmak için neye ihtiyacın var?</strong> <br />• Kendini ve işini sürekli güncelleyebilmen
                                    için yenilikçi ve araştırmacı bir ruha sahip olmalısın.<br />• Gerekli durumlarda
                                    ekibe koçluk edip, doğru zamanda doğru yerde olmalarını sağlamalısın.<br />• Zorlu
                                    durumlar ve kişiler ile başa çıkabilecek ikna yeteneğine sahip olmalısın. <br />∙
                                    Kriz durumlarında oluşabilecek stresi iyi yönetebilmeli, kritik anlarda bile çözüm
                                    odaklı olmalısın. <br />• Doğru organizasyon ve planlama ile zaman yönetimini en
                                    verimli şekilde kullanmalısın.</p>
                                <p><strong>Borusan’da biz:</strong><br />• Kendimizi geliştirmek için işimizi geliştirir; yeni bilgi ve
                                    beceriler edinerek, yeni sorumluluklar üstleniriz. Bilgiye karşı her zaman merak
                                    duyar, araştırır; yaşam boyu öğrenmenin gücüne inanırız.<br />• Gelecek için ortak
                                    hayaller kurar, hayallerimizi hayata geçirirken önceliklerimizi doğru belirler,
                                    çeviklikle harekete geçeriz. Pazarı, teknolojiyi, trendleri ve rakipleri yakından
                                    takip eder; pazardaki fırsatları en iyi şekilde değerlendirerek fark yaratırız. Her
                                    zaman işimizi daha iyi yapmanın yollarını ararız.<br />• Biliriz ki başarıya ancak
                                    açık ve şeffaf iletişim kuran, ortak akılla hareket eden takımlarla ulaşabiliriz. Bu
                                    nedenle daha iyiye ulaşmak için fikirlerimizi cesurca söyler, birbirimizin
                                    görüşlerini yapıcı bir şekilde sorgularız.<br />• İnsana ve çevreye değer veririz.
                                    Güçlü yan haklar ve kulüpler ile sosyal hayatımızın desteklendiğini bilir, sosyal
                                    sorumluluk projeleriyle iyilik peşinde koşarız.</p>
                                <p>Çünkü Borusan Burada!<br />İşe Alım Süreci Nasıl İşleyecek?<br />Aklına takılan tüm
                                    sorular için cevaplar burada!</p>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <img src="Uploads/testmail/images/index_03.png" width="640" height="130" alt=""></td>
                        </tr>
                        <tr>
                            <td>
                                <img src="Uploads/testmail/images/index_04.png" width="640" height="1" alt=""></td>
                        </tr>
                        <tr>
                            <td>
                                <table id="Table_01" width="640" height="99" border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td>
                                            <img src="Uploads/testmail/images/social_01.png" width="297" height="99"
                                                alt=""></td>
                                        <td>
                                            <img src="Uploads/testmail/images/social_02.png" width="47" height="99"
                                                alt=""></td>
                                        <td>
                                            <img src="Uploads/testmail/images/social_03.png" width="296" height="99"
                                                alt=""></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </center>', CAST(N'2019-12-13 20:59:34.183' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[SampleContent] OFF
SET IDENTITY_INSERT [dbo].[SoftSkill] ON 

INSERT [dbo].[SoftSkill] ([SoftSkillID], [CompanyID], [SoftSkillTag], [SoftSkillOpenningTextTR], [SoftSkillClosingTextTR], [SoftSkillOpenningTextEN], [SoftSkillClosingTextEN], [SoftSkillIsActive]) VALUES (1, 1, N'İletişim Yetenekleri', N'Kendi  fikirlerinizi başkalarının anlayabileceği şekilde aktarabilmek iletişimin başlangıcıdır. Bunun için vücut dilinizi iyi kullanmaktan görsel iletişime, topluluk önünde konuşmaktan yazma becerisine ya da sunum yeteneklerinden karşılıklı görüşmeye uzanan yeteneklerinizin farkında olmanız gerekir.', N'', N'Kendi fikirlerinizi başkalarının anlayabileceği şekilde aktarabilmek iletişimin başlangıcıdır. Bunun için vücut dilinizi iyi kullanmaktan görsel iletişime, topluluk önünde konuşmaktan yazma becerisine ya da sunum yeteneklerinden karşılıklı görüşmeye uzanan yeteneklerinizin farkında olmanız gerekir.', N'', 1)
INSERT [dbo].[SoftSkill] ([SoftSkillID], [CompanyID], [SoftSkillTag], [SoftSkillOpenningTextTR], [SoftSkillClosingTextTR], [SoftSkillOpenningTextEN], [SoftSkillClosingTextEN], [SoftSkillIsActive]) VALUES (2, 1, N'Çevreye Uyum', N'Bir çevreye ait olmak, bir takımın içinde çalışma yeteneği takımın verimliliğini ve birlikte sorun çözme yeteneğini geliştirir. Kişiler arası ilişkiler, network kurabilme ve zor insanlarla baş etmek potansiyel işverenlerin seçimlerini olumlu yönde etkileyecektir.', NULL, NULL, NULL, 1)
INSERT [dbo].[SoftSkill] ([SoftSkillID], [CompanyID], [SoftSkillTag], [SoftSkillOpenningTextTR], [SoftSkillClosingTextTR], [SoftSkillOpenningTextEN], [SoftSkillClosingTextEN], [SoftSkillIsActive]) VALUES (3, 2, N'Kişisel  Yetenekler', N'Özgüven, esneklik ve uyum her ortamda öne çıkmanızı sağlayacak değerli becerilerdir. Diğer insanlarla empati kurabilecek duygusal zekaya sahip olma, esneklik ve uyumla kendini yönlendirebilme ve girişkenlik ve kararlılıkla rekabet yeteneğin sektör ve firma  fark etmeksizin bir adım önde olmanı sağlayabilir.', NULL, NULL, NULL, 1)
INSERT [dbo].[SoftSkill] ([SoftSkillID], [CompanyID], [SoftSkillTag], [SoftSkillOpenningTextTR], [SoftSkillClosingTextTR], [SoftSkillOpenningTextEN], [SoftSkillClosingTextEN], [SoftSkillIsActive]) VALUES (4, 2, N'Liderlik', N'Liderlik Tanımı', NULL, NULL, NULL, 1)
INSERT [dbo].[SoftSkill] ([SoftSkillID], [CompanyID], [SoftSkillTag], [SoftSkillOpenningTextTR], [SoftSkillClosingTextTR], [SoftSkillOpenningTextEN], [SoftSkillClosingTextEN], [SoftSkillIsActive]) VALUES (5, 3, N'Yaratıcılık', N'Günümüz dünyasında belki de en çok öne çıkabileceğiniz özellik diyebiliriz.  Bu özellik  sayesinde yenilikçi yaklaşım, eleştirel düşünce yapısıyla problem çözebilme  yalnızca üretim aşamasında değil tüm süreçlere etki edecektir. Her konu için belirli bir tasarım ve sanat anlayışına sahip olabilmeniz kültürler arası bağlantıyı da kolaylaştıracaktır.', NULL, NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[SoftSkill] OFF
SET IDENTITY_INSERT [dbo].[Template] ON 

INSERT [dbo].[Template] ([TemplateID], [TemplateName], [TemplateDescription], [TemplateImage], [TemplateHTML], [TemplateIsActive]) VALUES (1, N'1 Satır Kısa Yazı', NULL, N'Content/images/yazi/1-satir.svg', N'', 1)
INSERT [dbo].[Template] ([TemplateID], [TemplateName], [TemplateDescription], [TemplateImage], [TemplateHTML], [TemplateIsActive]) VALUES (2, N'2 Satır Kısa Yazı', NULL, N'Content/images/yazi/2-satir.svg', N'', 1)
INSERT [dbo].[Template] ([TemplateID], [TemplateName], [TemplateDescription], [TemplateImage], [TemplateHTML], [TemplateIsActive]) VALUES (3, N'2 Sütun 1 Kısa Yazı', NULL, N'Content/images/yazi/2-sutun.svg', N'', 1)
INSERT [dbo].[Template] ([TemplateID], [TemplateName], [TemplateDescription], [TemplateImage], [TemplateHTML], [TemplateIsActive]) VALUES (4, N'2 Satır 2 Sütun Kısa Yazı', NULL, N'Content/images/yazi/2-satir-2-sutun.svg', N'', 1)
INSERT [dbo].[Template] ([TemplateID], [TemplateName], [TemplateDescription], [TemplateImage], [TemplateHTML], [TemplateIsActive]) VALUES (5, N'3 Satır 2 Sütun Kısa Yazı', NULL, N'Content/images/yazi/3-satir-2-sutun.svg', N'', 1)
INSERT [dbo].[Template] ([TemplateID], [TemplateName], [TemplateDescription], [TemplateImage], [TemplateHTML], [TemplateIsActive]) VALUES (6, N'1 Satır Uzun Yazı', NULL, N'Content/images/yazi/1-satir-uzun.svg', N'', 1)
SET IDENTITY_INSERT [dbo].[Template] OFF
ALTER TABLE [dbo].[Company] ADD  CONSTRAINT [DF_Company_CompanyIsActive]  DEFAULT ((1)) FOR [CompanyIsActive]
GO
ALTER TABLE [dbo].[Content] ADD  CONSTRAINT [DF_Content_ContentIsDraft]  DEFAULT ((0)) FOR [ContentIsDraft]
GO
ALTER TABLE [dbo].[Content] ADD  CONSTRAINT [DF_Content_ContentIsActive]  DEFAULT ((1)) FOR [ContentIsActive]
GO
ALTER TABLE [dbo].[ContentCategory] ADD  CONSTRAINT [DF_ContentCategory_ContentCategoryIsActive]  DEFAULT ((1)) FOR [ContentCategoryIsActive]
GO
ALTER TABLE [dbo].[ContentSoftSkill] ADD  CONSTRAINT [DF_ContentSoftSkill_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Department] ADD  CONSTRAINT [DF_Department_DepartmentIsActive]  DEFAULT ((1)) FOR [DepartmentIsActive]
GO
ALTER TABLE [dbo].[Gallery] ADD  CONSTRAINT [DF_Gallery_GalleryIsActive]  DEFAULT ((1)) FOR [GalleryIsActive]
GO
ALTER TABLE [dbo].[Language] ADD  CONSTRAINT [DF_Language_LanguageIsActive]  DEFAULT ((1)) FOR [LanguageIsActive]
GO
ALTER TABLE [dbo].[Member] ADD  CONSTRAINT [DF_Member_MemberIsActive]  DEFAULT ((0)) FOR [MemberIsActive]
GO
ALTER TABLE [dbo].[Role] ADD  CONSTRAINT [DF_Role_RoleIsActive]  DEFAULT ((1)) FOR [RoleIsActive]
GO
ALTER TABLE [dbo].[SampleContent] ADD  CONSTRAINT [DF_SampleContent_SampleContentIsActive]  DEFAULT ((1)) FOR [SampleContentIsActive]
GO
ALTER TABLE [dbo].[SoftSkill] ADD  CONSTRAINT [DF_SoftSkill_SoftSkillIsActive]  DEFAULT ((1)) FOR [SoftSkillIsActive]
GO
ALTER TABLE [dbo].[Template] ADD  CONSTRAINT [DF_Template_TemplateIsActive]  DEFAULT ((1)) FOR [TemplateIsActive]
GO
