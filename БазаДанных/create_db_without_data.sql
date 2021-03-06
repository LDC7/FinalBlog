USE [master]
GO
/****** Object:  Database [MyBLOGs]    Script Date: 06.09.2017 19:40:27 ******/
CREATE DATABASE [MyBLOGs]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'MyBLOGs', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\MyBLOGs.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'MyBLOGs_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\MyBLOGs_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [MyBLOGs] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MyBLOGs].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MyBLOGs] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MyBLOGs] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MyBLOGs] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MyBLOGs] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MyBLOGs] SET ARITHABORT OFF 
GO
ALTER DATABASE [MyBLOGs] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [MyBLOGs] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MyBLOGs] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MyBLOGs] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MyBLOGs] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [MyBLOGs] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MyBLOGs] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MyBLOGs] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MyBLOGs] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MyBLOGs] SET  DISABLE_BROKER 
GO
ALTER DATABASE [MyBLOGs] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MyBLOGs] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MyBLOGs] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [MyBLOGs] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [MyBLOGs] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MyBLOGs] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [MyBLOGs] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [MyBLOGs] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [MyBLOGs] SET  MULTI_USER 
GO
ALTER DATABASE [MyBLOGs] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [MyBLOGs] SET DB_CHAINING OFF 
GO
ALTER DATABASE [MyBLOGs] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [MyBLOGs] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [MyBLOGs] SET DELAYED_DURABILITY = DISABLED 
GO
USE [MyBLOGs]
GO
/****** Object:  Table [dbo].[Articles]    Script Date: 06.09.2017 19:40:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Articles](
	[PK_ArticleID] [int] IDENTITY(1,1) NOT NULL,
	[FK_UserID] [int] NOT NULL,
	[Status] [nvarchar](10) NOT NULL CONSTRAINT [DF__Articles__Status__628FA481]  DEFAULT ('Default'),
	[Rating] [int] NOT NULL CONSTRAINT [DF__Articles__Rating__6383C8BA]  DEFAULT ('0'),
	[UploadDate] [datetime] NOT NULL,
	[Title] [nvarchar](50) NOT NULL,
	[ArticleText] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_ARTICLES] PRIMARY KEY CLUSTERED 
(
	[PK_ArticleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Articles_Tags_Relations]    Script Date: 06.09.2017 19:40:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Articles_Tags_Relations](
	[FK_ArticleID] [int] NOT NULL,
	[FK_TagID] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BlockedUsers]    Script Date: 06.09.2017 19:40:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BlockedUsers](
	[FK_UserID] [int] NOT NULL,
	[BlockDate] [datetime] NOT NULL,
	[ReleaseDate] [datetime] NULL,
	[Reason] [nvarchar](50) NULL,
 CONSTRAINT [PK_BLOCKEDUSERS] PRIMARY KEY CLUSTERED 
(
	[FK_UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ__BlockedU__00684B4431B17721] UNIQUE NONCLUSTERED 
(
	[FK_UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Comments]    Script Date: 06.09.2017 19:40:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comments](
	[PK_CommentID] [int] IDENTITY(1,1) NOT NULL,
	[FK_UserID] [int] NOT NULL,
	[FK_ArticleID] [int] NOT NULL,
	[CommentDate] [datetime] NOT NULL,
	[CommentText] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_COMMENTS] PRIMARY KEY CLUSTERED 
(
	[PK_CommentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Rating]    Script Date: 06.09.2017 19:40:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rating](
	[FK_UserID] [int] NOT NULL,
	[FK_ArticleID] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Sessions]    Script Date: 06.09.2017 19:40:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sessions](
	[FK_UserID] [int] NOT NULL,
	[StartSession] [datetime] NOT NULL,
	[EndSession] [datetime] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tags]    Script Date: 06.09.2017 19:40:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tags](
	[PK_TagID] [int] IDENTITY(1,1) NOT NULL,
	[TagText] [nvarchar](15) NOT NULL,
 CONSTRAINT [PK_TAGS] PRIMARY KEY CLUSTERED 
(
	[PK_TagID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ__Tags__2CB6506EC98D66EF] UNIQUE NONCLUSTERED 
(
	[TagText] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Users]    Script Date: 06.09.2017 19:40:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Users](
	[PK_UserID] [int] IDENTITY(1,1) NOT NULL,
	[Status] [nvarchar](10) NOT NULL CONSTRAINT [DF__Users__Status__5FB337D6]  DEFAULT ('user'),
	[Nickname] [nvarchar](30) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[Password] [varbinary](20) NOT NULL,
 CONSTRAINT [PK_USERS] PRIMARY KEY CLUSTERED 
(
	[PK_UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Articles]  WITH CHECK ADD  CONSTRAINT [Articles_fk0] FOREIGN KEY([FK_UserID])
REFERENCES [dbo].[Users] ([PK_UserID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Articles] CHECK CONSTRAINT [Articles_fk0]
GO
ALTER TABLE [dbo].[Articles_Tags_Relations]  WITH CHECK ADD  CONSTRAINT [Articles_Tags_Relations_fk0] FOREIGN KEY([FK_ArticleID])
REFERENCES [dbo].[Articles] ([PK_ArticleID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Articles_Tags_Relations] CHECK CONSTRAINT [Articles_Tags_Relations_fk0]
GO
ALTER TABLE [dbo].[Articles_Tags_Relations]  WITH CHECK ADD  CONSTRAINT [Articles_Tags_Relations_fk1] FOREIGN KEY([FK_TagID])
REFERENCES [dbo].[Tags] ([PK_TagID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Articles_Tags_Relations] CHECK CONSTRAINT [Articles_Tags_Relations_fk1]
GO
ALTER TABLE [dbo].[BlockedUsers]  WITH CHECK ADD  CONSTRAINT [BlockedUsers_fk0] FOREIGN KEY([FK_UserID])
REFERENCES [dbo].[Users] ([PK_UserID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[BlockedUsers] CHECK CONSTRAINT [BlockedUsers_fk0]
GO
ALTER TABLE [dbo].[Comments]  WITH CHECK ADD  CONSTRAINT [Comments_fk0] FOREIGN KEY([FK_UserID])
REFERENCES [dbo].[Users] ([PK_UserID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Comments] CHECK CONSTRAINT [Comments_fk0]
GO
ALTER TABLE [dbo].[Rating]  WITH CHECK ADD  CONSTRAINT [Rating_fk0] FOREIGN KEY([FK_UserID])
REFERENCES [dbo].[Users] ([PK_UserID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Rating] CHECK CONSTRAINT [Rating_fk0]
GO
ALTER TABLE [dbo].[Sessions]  WITH CHECK ADD  CONSTRAINT [Sessions_fk0] FOREIGN KEY([FK_UserID])
REFERENCES [dbo].[Users] ([PK_UserID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Sessions] CHECK CONSTRAINT [Sessions_fk0]
GO
/****** Object:  StoredProcedure [dbo].[AddArticle]    Script Date: 06.09.2017 19:40:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddArticle]
	@UserId int,
	@Title nvarchar(50),
	@Text nvarchar(max)
AS
	INSERT INTO [dbo].[Articles]
           ([FK_UserID]
           ,[UploadDate]
           ,[Title]
           ,[ArticleText])
     VALUES
           (@UserId
           ,GETDATE()
           ,@Title
           ,@Text)

	SELECT CONVERT(int, @@IDENTITY)

GO
/****** Object:  StoredProcedure [dbo].[AddComment]    Script Date: 06.09.2017 19:40:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddComment]
	@UserId int,
	@ArticleId int,
	@Text nvarchar(max)
AS
	INSERT INTO [dbo].[Comments]
           ([FK_UserID]
           ,[FK_ArticleID]
           ,[CommentDate]
           ,[CommentText])
	VALUES
           (@UserId
           ,@ArticleId
           ,GETDATE()
           ,@Text)

GO
/****** Object:  StoredProcedure [dbo].[AddRating]    Script Date: 06.09.2017 19:40:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddRating]
	@UserId int,
	@ArticleId int,
	@Rating smallint
AS
	IF NOT EXISTS (SELECT * FROM [dbo].[Rating] WHERE [FK_UserID] = @UserId AND [FK_ArticleID] = @ArticleId)
	BEGIN
		INSERT INTO [dbo].[Rating]
		       ([FK_UserID]
		       ,[FK_ArticleID])
		VALUES
		       (@UserId
		       ,@ArticleId)

		UPDATE [dbo].[Articles]
		SET [Rating] = [Rating] + @Rating
		WHERE [PK_ArticleID] = @ArticleId
	END
GO
/****** Object:  StoredProcedure [dbo].[AddTag]    Script Date: 06.09.2017 19:40:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddTag]
	@TagText nvarchar(15)
AS
	IF NOT EXISTS (SELECT [PK_TagID] FROM [dbo].[Tags] WHERE [TagText] = @TagText)
	INSERT INTO [dbo].[Tags]
		([TagText])
	VALUES
		(@TagText)

	SELECT [PK_TagID] FROM [dbo].[Tags] WHERE [TagText] = @TagText

GO
/****** Object:  StoredProcedure [dbo].[AddTagRelation]    Script Date: 06.09.2017 19:40:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddTagRelation]
	@ArticleId int,
	@TagId int
AS
	INSERT INTO [dbo].[Articles_Tags_Relations]
           ([FK_ArticleID]
           ,[FK_TagID])
	VALUES
           (@ArticleId
           ,@TagId)

GO
/****** Object:  StoredProcedure [dbo].[AddUser]    Script Date: 06.09.2017 19:40:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddUser]
    @Nick nvarchar(30),
    @Email nvarchar(50),
    @Password nvarchar(20)
AS
	IF ((SELECT COUNT(PK_UserID) FROM [dbo].[Users] WHERE [Nickname] = @Nick) > 0
	OR (SELECT COUNT(PK_UserID) FROM [dbo].[Users] WHERE [Email] = @Email) > 0)
	SELECT null
	ELSE BEGIN
		INSERT INTO [dbo].[Users]
		       ([Nickname]
		       ,[Email]
		       ,[Password])
		VALUES
		       (@Nick
		       ,@Email
		       ,HASHBYTES('SHA1', @Password))

		SELECT PK_UserID FROM [dbo].[Users] WHERE [Email] = @Email
	END

GO
/****** Object:  StoredProcedure [dbo].[AuthUser]    Script Date: 06.09.2017 19:40:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AuthUser]
	@Email nvarchar(50),
	@Password nvarchar(20)
AS
	DECLARE @Flag bit = 0

	IF EXISTS(SELECT * FROM [dbo].[Users] WHERE [Email] = @Email AND [Password] = HASHBYTES('SHA1', @Password))
	BEGIN
		SET @Flag = 1
	END

	SELECT @Flag

GO
/****** Object:  StoredProcedure [dbo].[BlockUser]    Script Date: 06.09.2017 19:40:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BlockUser]
    @UserId int,
	@Period int = null,
	@Reason nvarchar(50) = null
AS
	DECLARE @BlockDate datetime = CAST(GETDATE() AS datetime)
	DECLARE @ReleaseDate datetime = null

	IF @Period IS NOT NULL
	SET @ReleaseDate = dateadd(mi, @Period, GETDATE())

	IF (SELECT [Status] FROM [dbo].[Users] WHERE [PK_UserID] = @UserId) = 'blocked'
	BEGIN
		IF (@ReleaseDate IS NULL
		OR ((SELECT [ReleaseDate] FROM [dbo].[BlockedUsers] WHERE [FK_UserID] = @UserId) < @ReleaseDate))
		BEGIN
			UPDATE [dbo].[BlockedUsers]
			SET [BlockDate] = @BlockDate
				,[ReleaseDate] = @ReleaseDate
				,[Reason] = @Reason
			WHERE [FK_UserID] = @UserId
		END
	END
	ELSE BEGIN
		UPDATE [dbo].[Users]
		SET [Status] = 'blocked'
		WHERE [PK_UserID] = @UserId

		INSERT INTO [dbo].[BlockedUsers]
           ([FK_UserID]
           ,[BlockDate]
           ,[ReleaseDate]
           ,[Reason])
		VALUES
           (@UserId
           ,@BlockDate
           ,@ReleaseDate
           ,@Reason)
	END

GO
/****** Object:  StoredProcedure [dbo].[ChageArticleStatus]    Script Date: 06.09.2017 19:40:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ChageArticleStatus]
	@ArticleId int,
	@Status nvarchar(10)
AS
	UPDATE [dbo].[Articles]
	SET [Status] = @Status
	WHERE [PK_ArticleID] = @ArticleId

GO
/****** Object:  StoredProcedure [dbo].[ChangeUserStatus]    Script Date: 06.09.2017 19:40:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ChangeUserStatus]
    @UserId int,
    @NewStatus nvarchar(10)
AS
	UPDATE [dbo].[Users]
	SET [Status] = @NewStatus
	WHERE PK_UserID = @UserId

GO
/****** Object:  StoredProcedure [dbo].[CheckSession]    Script Date: 06.09.2017 19:40:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CheckSession]
	@UserId int
AS
	DECLARE @Flag bit = 0

	IF EXISTS (SELECT * FROM [dbo].[Sessions] WHERE [FK_UserID] = @UserId)
	BEGIN
		DECLARE @StartTime datetime
		DECLARE @EndTime datetime
		SELECT @StartTime = [StartSession], @EndTime = [EndSession]  FROM [dbo].[Sessions] WHERE [FK_UserID] = @UserId
		IF (GETDATE() < @EndTime)
		SET @Flag = 1
		ELSE
		BEGIN
			DELETE FROM [dbo].[Sessions] WHERE [FK_UserID] = @UserId
		END
	END

	SELECT @Flag

GO
/****** Object:  StoredProcedure [dbo].[CheckUserStatus]    Script Date: 06.09.2017 19:40:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CheckUserStatus]
    @UserId int
AS
	DECLARE @Status varchar(10)
	SELECT @Status = [Status] FROM [dbo].[Users] WHERE [PK_UserID] = @UserId
	IF @Status = 'blocked'
	BEGIN
		IF (SELECT [ReleaseDate] FROM [dbo].[BlockedUsers] WHERE [FK_UserID] = @UserId) <= GETDATE()
		BEGIN
			DELETE FROM [dbo].[BlockedUsers] WHERE [FK_UserID] = @UserId
			UPDATE [dbo].[Users] SET [Status] = 'user' WHERE [PK_UserID] = @UserId
		END
	END

	SELECT [Status] FROM [dbo].[Users] WHERE [PK_UserID] = @UserId

GO
/****** Object:  StoredProcedure [dbo].[CheckUserVote]    Script Date: 06.09.2017 19:40:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CheckUserVote]
	@UserId int,
	@ArticleId int
AS
	DECLARE @Flag bit = 0

	IF NOT EXISTS ( SELECT *
		FROM [dbo].[Rating]
		WHERE [FK_UserID] = @UserId AND [FK_ArticleID] = @ArticleId )
	SET @Flag = 1

	SELECT @Flag

GO
/****** Object:  StoredProcedure [dbo].[CreateSession]    Script Date: 06.09.2017 19:40:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CreateSession]
	@UserId int
AS
	INSERT INTO [dbo].[Sessions]
           ([FK_UserID]
           ,[StartSession]
           ,[EndSession])
	VALUES
           (@UserId
           ,GETDATE()
           ,dateadd(mi, 150, GETDATE()))

GO
/****** Object:  StoredProcedure [dbo].[DeleteArticle]    Script Date: 06.09.2017 19:40:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteArticle]
	@ArticleId int
AS
	DELETE FROM [dbo].[Articles_Tags_Relations]
	WHERE [FK_ArticleID] = @ArticleId

	DELETE FROM [dbo].[Comments]
	WHERE [FK_ArticleID] = @ArticleId

	DELETE FROM [dbo].[Rating]
	WHERE [FK_ArticleID] = @ArticleId

	DELETE FROM [dbo].[Articles]
	WHERE [PK_ArticleID] = @ArticleId
GO
/****** Object:  StoredProcedure [dbo].[DeleteComment]    Script Date: 06.09.2017 19:40:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteComment]
	@CommentId int
AS
	DELETE FROM [dbo].[Comments]
	WHERE [PK_CommentID] = @CommentId

GO
/****** Object:  StoredProcedure [dbo].[DeleteSession]    Script Date: 06.09.2017 19:40:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteSession]
	@UserId int
AS
	DELETE FROM [dbo].[Sessions] WHERE [FK_UserID] = @UserId

GO
/****** Object:  StoredProcedure [dbo].[DeleteUselessTags]    Script Date: 06.09.2017 19:40:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteUselessTags]
AS
	DELETE FROM [dbo].[Tags]
	WHERE [PK_TagID] IN (
		SELECT [PK_TagID] FROM [dbo].[Tags]
		WHERE [PK_TagID] NOT IN (
			SELECT [FK_TagID] FROM [dbo].[Articles_Tags_Relations]
		)
	)

GO
/****** Object:  StoredProcedure [dbo].[GetAllArticles]    Script Date: 06.09.2017 19:40:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAllArticles]
AS
	SELECT [PK_ArticleID], [FK_UserID], [Nickname], a.[Status], [Rating], [UploadDate], [Title], [ArticleText]
	FROM [dbo].[Articles] a
	JOIN [dbo].[Users] u ON a.[FK_UserID] = u.[PK_UserID]
	WHERE a.[Status] != 'Blocked'
	ORDER BY [UploadDate] DESC

GO
/****** Object:  StoredProcedure [dbo].[GetArticle]    Script Date: 06.09.2017 19:40:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetArticle]
	@ArticleId int
AS
	SELECT [PK_ArticleID], [FK_UserID], [Nickname], a.[Status], [Rating], [UploadDate], [Title], [ArticleText]
	FROM [dbo].[Articles] a
	JOIN [dbo].[Users] u ON a.[FK_UserID] = u.[PK_UserID]
	WHERE [PK_ArticleID] = @ArticleId

GO
/****** Object:  StoredProcedure [dbo].[GetArticleByTag]    Script Date: 06.09.2017 19:40:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetArticleByTag]
	@TagId int
AS
	SELECT [PK_ArticleID], [FK_UserID], [Nickname], a.[Status], [Rating], [UploadDate], [Title], [ArticleText]
	FROM [dbo].[Articles] a
	JOIN [dbo].[Users] u ON a.[FK_UserID] = u.[PK_UserID]
	JOIN [dbo].[Articles_Tags_Relations] atr ON a.[PK_ArticleID] = atr.[FK_ArticleID]
	WHERE atr.[FK_TagID] = @TagId AND a.[Status] != 'Blocked'
	ORDER BY [UploadDate] DESC

GO
/****** Object:  StoredProcedure [dbo].[GetArticleByText]    Script Date: 06.09.2017 19:40:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetArticleByText]
	@SearchText nvarchar(100)
AS
	SELECT [PK_ArticleID], [FK_UserID], [Nickname], a.[Status], [Rating], [UploadDate], [Title], [ArticleText]
	FROM [dbo].[Articles] a
	JOIN [dbo].[Users] u ON a.[FK_UserID] = u.[PK_UserID]
	WHERE (a.[Status] != 'Blocked' AND
		([Title] LIKE '%'+@SearchText+'%' OR [ArticleText] LIKE '%'+@SearchText+'%' OR
		[PK_ArticleID] IN (
			SELECT [FK_ArticleId]
			FROM [dbo].[Articles_Tags_Relations] atr
			JOIN [dbo].[Tags] t ON t.[PK_TagID] = atr.[FK_TagID]
			WHERE t.[TagText] LIKE '%'+@SearchText+'%'
			)
		))
	ORDER BY [UploadDate] DESC

GO
/****** Object:  StoredProcedure [dbo].[GetBlockedArticles]    Script Date: 06.09.2017 19:40:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetBlockedArticles]
AS
	SELECT [PK_ArticleID], [FK_UserID], [Nickname], a.[Status], [Rating], [UploadDate], [Title], [ArticleText]
	FROM [dbo].[Articles] a
	JOIN [dbo].[Users] u ON a.[FK_UserID] = u.[PK_UserID]
	WHERE a.[Status] = 'Blocked'
	ORDER BY [UploadDate]

GO
/****** Object:  StoredProcedure [dbo].[GetBlockUser]    Script Date: 06.09.2017 19:40:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetBlockUser]
	@UserId int
AS
	SELECT [FK_UserID], [BlockDate] ,[ReleaseDate] ,[Reason]
	FROM [dbo].[BlockedUsers]
	WHERE [FK_UserID] = @UserId

GO
/****** Object:  StoredProcedure [dbo].[GetComments]    Script Date: 06.09.2017 19:40:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetComments]
	@ArticleId int
AS
	SELECT [PK_CommentID]
      ,[FK_UserID]
	  ,[Nickname]
      ,[FK_ArticleID]
      ,[CommentDate]
      ,[CommentText]
	FROM [dbo].[Comments] c
	JOIN [dbo].[Users] u ON u.[PK_UserID] = c.[FK_UserID]
	WHERE [FK_ArticleID] = @ArticleId
	ORDER BY [CommentDate] DESC

GO
/****** Object:  StoredProcedure [dbo].[GetTag]    Script Date: 06.09.2017 19:40:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetTag]
	@TagId int
AS
	SELECT [TagText]
	FROM [dbo].[Tags]
	WHERE [PK_TagID] = @TagId

GO
/****** Object:  StoredProcedure [dbo].[GetTags]    Script Date: 06.09.2017 19:40:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetTags]
	@ArticleId int
AS
	SELECT [PK_TagID], [TagText] FROM [dbo].[Tags]
	WHERE [PK_TagID] IN (
		SELECT [FK_TagID] FROM [dbo].[Articles_Tags_Relations] WHERE [FK_ArticleID] = @ArticleId )

GO
/****** Object:  StoredProcedure [dbo].[GetUserArticles]    Script Date: 06.09.2017 19:40:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetUserArticles]
	@UserId int
AS
	SELECT [PK_ArticleID], [FK_UserID], [Status], [Rating], [UploadDate], [Title], [ArticleText]
	FROM [dbo].[Articles]
	WHERE [FK_UserId] = @UserId AND [Status] != 'Blocked'
	ORDER BY [UploadDate] DESC

GO
/****** Object:  StoredProcedure [dbo].[GetUserByNick]    Script Date: 06.09.2017 19:40:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetUserByNick]
	@Nick nvarchar(30)
AS
	SELECT [PK_UserID], [Status], [Email], [Nickname]
	FROM [dbo].[Users]
	WHERE [Nickname] = @Nick

GO
/****** Object:  StoredProcedure [dbo].[GetUserId]    Script Date: 06.09.2017 19:40:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetUserId]
	@Email nvarchar(50)
AS
	SELECT [PK_UserID] FROM [dbo].[Users] WHERE [Email] = @Email

GO
/****** Object:  StoredProcedure [dbo].[GetUserIdByNick]    Script Date: 06.09.2017 19:40:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetUserIdByNick]
	@Nick nvarchar(30)
AS
	SELECT [PK_UserID]
	FROM [dbo].[Users]
	WHERE [Nickname] = @Nick

GO
/****** Object:  StoredProcedure [dbo].[GetUserInfo]    Script Date: 06.09.2017 19:40:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetUserInfo]
	@UserId int
AS
	SELECT [PK_UserID], [Status], [Nickname], [Email] FROM [dbo].[Users] WHERE [PK_UserID] = @UserId

GO
/****** Object:  StoredProcedure [dbo].[UnBlockUser]    Script Date: 06.09.2017 19:40:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UnBlockUser]
    @UserId int
AS
	IF (SELECT [Status] FROM [dbo].[Users] WHERE [PK_UserID] = @UserId) = 'blocked'
	BEGIN
		DELETE FROM [dbo].[BlockedUsers] WHERE [FK_UserID] = @UserId
		UPDATE [dbo].[Users] SET [Status] = 'user' WHERE [PK_UserID] = @UserId
	END

GO
USE [master]
GO
ALTER DATABASE [MyBLOGs] SET  READ_WRITE 
GO
