USE [master]
GO
/****** Object:  Database [MyBLOGs]    Script Date: 11.09.2017 10:39:04 ******/
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
ALTER DATABASE [MyBLOGs] SET AUTO_CLOSE ON 
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
/****** Object:  Table [dbo].[Articles]    Script Date: 11.09.2017 10:39:04 ******/
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
/****** Object:  Table [dbo].[Articles_Tags_Relations]    Script Date: 11.09.2017 10:39:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Articles_Tags_Relations](
	[FK_ArticleID] [int] NOT NULL,
	[FK_TagID] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BlockedUsers]    Script Date: 11.09.2017 10:39:04 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Comments]    Script Date: 11.09.2017 10:39:04 ******/
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
/****** Object:  Table [dbo].[Rating]    Script Date: 11.09.2017 10:39:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rating](
	[FK_UserID] [int] NOT NULL,
	[FK_ArticleID] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Sessions]    Script Date: 11.09.2017 10:39:04 ******/
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
/****** Object:  Table [dbo].[Tags]    Script Date: 11.09.2017 10:39:04 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Users]    Script Date: 11.09.2017 10:39:04 ******/
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
SET IDENTITY_INSERT [dbo].[Articles] ON 

INSERT [dbo].[Articles] ([PK_ArticleID], [FK_UserID], [Status], [Rating], [UploadDate], [Title], [ArticleText]) VALUES (1, 1, N'Default', 0, CAST(N'2017-09-04 10:08:33.997' AS DateTime), N'1 Тестовый пост', N'Тут могла быть ваша реклама')
INSERT [dbo].[Articles] ([PK_ArticleID], [FK_UserID], [Status], [Rating], [UploadDate], [Title], [ArticleText]) VALUES (2, 1, N'Default', 0, CAST(N'2017-09-04 10:09:25.227' AS DateTime), N'2 Тестовый пост', N'isouhgl[o;fsdkfhg[opewrkhgjsd')
INSERT [dbo].[Articles] ([PK_ArticleID], [FK_UserID], [Status], [Rating], [UploadDate], [Title], [ArticleText]) VALUES (3, 1, N'Default', 0, CAST(N'2017-09-04 10:09:51.877' AS DateTime), N'3 Тестовый пост', N'В этом тексте есть слово ЯбЛоКо')
INSERT [dbo].[Articles] ([PK_ArticleID], [FK_UserID], [Status], [Rating], [UploadDate], [Title], [ArticleText]) VALUES (6, 1, N'Default', 0, CAST(N'2017-09-04 10:13:48.413' AS DateTime), N'6 Тестовый пост', N'Византи?я, Византи?йская импе?рия, Восто?чная Ри?мская импе?рия (395[4]—1453) — государство, сформировавшееся в 395 году вследствие окончательного раздела Римской империи, после смерти императора Феодосия I, на западную и восточную части. Чуть больше чем через восемьдесят лет после раздела Западная Римская империя прекратила своё существование, оставив Византию исторической, культурной и цивилизационной преемницей Древнего Рима на протяжении почти десяти столетий истории Поздней Античности и Средневековья[5][6].

Название «Византийская» Восточная Римская империя получила в трудах западноевропейских историков уже после своего падения, оно происходит от первоначального названия Константинополя — Виза?нтий (греч. ?????????, лат. Byzantium), куда римский император Константин I перенёс в 330 году столицу Римской империи, официально переименовав город в «Новый Рим»[7]. Сами византийцы называли себя римлянами — по-гречески «ромеями»[7], а свою державу — «Римской („Ромейской“) империей» (на среднегреческом (византийском) языке — ???????? ???????, Васили?я Роме?он) или кратко «Романией» (???????, Романи?я). Западные источники на протяжении большей части византийской истории именовали её «империей греков» из-за преобладания в ней с VII века греческого языка, эллинизированного населения и культуры. В Древней Руси Византию обычно называли «Греческим царством», а её столицу — Царьградом.

Бессменной столицей и цивилизационным центром Византийской империи был Константинополь[8], один из крупнейших городов средневекового мира. Наибольшие владения империя контролировала при императоре Юстиниане I (527—565), вернув себе на несколько десятилетий значительную часть прибрежных территорий бывших западных провинций Рима и положение самой могущественной средиземноморской державы. В дальнейшем под натиском многочисленных врагов государство постепенно утрачивало земли. После славянских, лангобардских, вестготских и арабских завоеваний империя занимала лишь территорию Греции и Малой Азии. Некоторое усиление в IX—XI веках сменилось серьёзными потерями в конце XI века, во время нашествия Сельджуков, и поражения при Манцикерте, усилением при первых Комнинах, после распада страны под ударами крестоносцев, взявших Константинополь в 1204 году, очередным усилением при Иоанне Ватаце, восстановлением империи Михаилом Палеологом, и, наконец, окончательной гибелью в середине XV века под натиском османов.')
INSERT [dbo].[Articles] ([PK_ArticleID], [FK_UserID], [Status], [Rating], [UploadDate], [Title], [ArticleText]) VALUES (7, 1, N'Default', 0, CAST(N'2017-09-04 10:34:23.410' AS DateTime), N'7 Тестовый пост Молоко', N'В этом посту в названии есть слово Молоко')
INSERT [dbo].[Articles] ([PK_ArticleID], [FK_UserID], [Status], [Rating], [UploadDate], [Title], [ArticleText]) VALUES (8, 1, N'ReadOnly', 1, CAST(N'2017-09-04 10:34:56.670' AS DateTime), N'8 Тестовый пост', N'В этом посту должны быть отключены комментарии')
INSERT [dbo].[Articles] ([PK_ArticleID], [FK_UserID], [Status], [Rating], [UploadDate], [Title], [ArticleText]) VALUES (9, 1, N'Blocked', 0, CAST(N'2017-09-04 10:35:23.840' AS DateTime), N'9 Тестовый пост', N'Этот пост должен быть доступен только модераторам и администраторам')
INSERT [dbo].[Articles] ([PK_ArticleID], [FK_UserID], [Status], [Rating], [UploadDate], [Title], [ArticleText]) VALUES (11, 1, N'Default', 0, CAST(N'2017-09-04 13:47:09.150' AS DateTime), N'10 Тестовый пост', N'В этом посте есть комментарии')
INSERT [dbo].[Articles] ([PK_ArticleID], [FK_UserID], [Status], [Rating], [UploadDate], [Title], [ArticleText]) VALUES (12, 1, N'Default', -1, CAST(N'2017-09-04 13:47:31.570' AS DateTime), N'11 Тестовый пост', N'В этом посте есть теги')
INSERT [dbo].[Articles] ([PK_ArticleID], [FK_UserID], [Status], [Rating], [UploadDate], [Title], [ArticleText]) VALUES (13, 7, N'Default', -1, CAST(N'2017-09-05 23:22:51.997' AS DateTime), N'Ещё тестовый пост', N'Этот пост написан не 1 администратором!')
INSERT [dbo].[Articles] ([PK_ArticleID], [FK_UserID], [Status], [Rating], [UploadDate], [Title], [ArticleText]) VALUES (14, 7, N'Default', -2, CAST(N'2017-09-06 09:44:47.333' AS DateTime), N'Учётка', N'Администратор2:
Логин(email): admin2@mail.ru
пароль: 123')
INSERT [dbo].[Articles] ([PK_ArticleID], [FK_UserID], [Status], [Rating], [UploadDate], [Title], [ArticleText]) VALUES (20, 8, N'Default', 1, CAST(N'2017-09-06 15:00:19.440' AS DateTime), N'Пост написанный Юзером', N'Тут какой-то текст')
SET IDENTITY_INSERT [dbo].[Articles] OFF
INSERT [dbo].[Articles_Tags_Relations] ([FK_ArticleID], [FK_TagID]) VALUES (12, 1)
INSERT [dbo].[Articles_Tags_Relations] ([FK_ArticleID], [FK_TagID]) VALUES (12, 2)
INSERT [dbo].[Articles_Tags_Relations] ([FK_ArticleID], [FK_TagID]) VALUES (14, 3)
INSERT [dbo].[Articles_Tags_Relations] ([FK_ArticleID], [FK_TagID]) VALUES (20, 9)
INSERT [dbo].[Articles_Tags_Relations] ([FK_ArticleID], [FK_TagID]) VALUES (20, 10)
INSERT [dbo].[BlockedUsers] ([FK_UserID], [BlockDate], [ReleaseDate], [Reason]) VALUES (3, CAST(N'2017-08-26 16:32:35.400' AS DateTime), CAST(N'2057-08-05 12:35:29.123' AS DateTime), N'Временный бан')
INSERT [dbo].[BlockedUsers] ([FK_UserID], [BlockDate], [ReleaseDate], [Reason]) VALUES (5, CAST(N'2017-08-26 16:30:20.707' AS DateTime), NULL, N'Перманент')
SET IDENTITY_INSERT [dbo].[Comments] ON 

INSERT [dbo].[Comments] ([PK_CommentID], [FK_UserID], [FK_ArticleID], [CommentDate], [CommentText]) VALUES (1, 1, 11, CAST(N'2017-09-04 13:49:40.140' AS DateTime), N'Это мой пост')
INSERT [dbo].[Comments] ([PK_CommentID], [FK_UserID], [FK_ArticleID], [CommentDate], [CommentText]) VALUES (2, 2, 11, CAST(N'2017-09-04 13:49:55.880' AS DateTime), N'Это мой комментарий')
INSERT [dbo].[Comments] ([PK_CommentID], [FK_UserID], [FK_ArticleID], [CommentDate], [CommentText]) VALUES (3, 3, 11, CAST(N'2017-09-04 13:50:11.587' AS DateTime), N'Это мой комментарий')
INSERT [dbo].[Comments] ([PK_CommentID], [FK_UserID], [FK_ArticleID], [CommentDate], [CommentText]) VALUES (4, 1, 12, CAST(N'2017-09-05 14:33:08.843' AS DateTime), N'sdxzxvzx')
INSERT [dbo].[Comments] ([PK_CommentID], [FK_UserID], [FK_ArticleID], [CommentDate], [CommentText]) VALUES (5, 1, 11, CAST(N'2017-09-05 14:34:24.330' AS DateTime), N'354r5[pifedrh')
SET IDENTITY_INSERT [dbo].[Comments] OFF
INSERT [dbo].[Rating] ([FK_UserID], [FK_ArticleID]) VALUES (7, 13)
INSERT [dbo].[Rating] ([FK_UserID], [FK_ArticleID]) VALUES (7, 14)
INSERT [dbo].[Rating] ([FK_UserID], [FK_ArticleID]) VALUES (7, 12)
INSERT [dbo].[Rating] ([FK_UserID], [FK_ArticleID]) VALUES (7, 8)
INSERT [dbo].[Rating] ([FK_UserID], [FK_ArticleID]) VALUES (1, 14)
INSERT [dbo].[Rating] ([FK_UserID], [FK_ArticleID]) VALUES (8, 20)
INSERT [dbo].[Sessions] ([FK_UserID], [StartSession], [EndSession]) VALUES (7, CAST(N'2017-09-06 18:51:25.157' AS DateTime), CAST(N'2017-09-06 21:21:25.157' AS DateTime))
INSERT [dbo].[Sessions] ([FK_UserID], [StartSession], [EndSession]) VALUES (1, CAST(N'2017-09-09 16:49:29.793' AS DateTime), CAST(N'2017-09-09 19:19:29.793' AS DateTime))
SET IDENTITY_INSERT [dbo].[Tags] ON 

INSERT [dbo].[Tags] ([PK_TagID], [TagText]) VALUES (10, N' тег2')
INSERT [dbo].[Tags] ([PK_TagID], [TagText]) VALUES (3, N'Администратор2:')
INSERT [dbo].[Tags] ([PK_TagID], [TagText]) VALUES (2, N'Спецтег')
INSERT [dbo].[Tags] ([PK_TagID], [TagText]) VALUES (9, N'тег1')
INSERT [dbo].[Tags] ([PK_TagID], [TagText]) VALUES (1, N'Тестовый тег')
SET IDENTITY_INSERT [dbo].[Tags] OFF
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([PK_UserID], [Status], [Nickname], [Email], [Password]) VALUES (1, N'admin', N'Administrator№1', N'lihwar1@gmail.com', 0x0D5399508427CE79556CDA71918020C1E8D15B53)
INSERT [dbo].[Users] ([PK_UserID], [Status], [Nickname], [Email], [Password]) VALUES (2, N'moder', N'Moderator№1', N'moder@mail.ru', 0x0D5399508427CE79556CDA71918020C1E8D15B53)
INSERT [dbo].[Users] ([PK_UserID], [Status], [Nickname], [Email], [Password]) VALUES (3, N'blocked', N'NaughtyBoy', N'naughtyboy@mail.ru', 0x0D5399508427CE79556CDA71918020C1E8D15B53)
INSERT [dbo].[Users] ([PK_UserID], [Status], [Nickname], [Email], [Password]) VALUES (4, N'moder', N'Moderator№2', N'moder2@mail.ru', 0x0D5399508427CE79556CDA71918020C1E8D15B53)
INSERT [dbo].[Users] ([PK_UserID], [Status], [Nickname], [Email], [Password]) VALUES (5, N'blocked', N'BadBoy', N'badboy@mail.ru', 0x0D5399508427CE79556CDA71918020C1E8D15B53)
INSERT [dbo].[Users] ([PK_UserID], [Status], [Nickname], [Email], [Password]) VALUES (6, N'user', N'User№1', N'user@mail.ru', 0x139F69C93C042496A8E958EC5930662C6CCCAFBF)
INSERT [dbo].[Users] ([PK_UserID], [Status], [Nickname], [Email], [Password]) VALUES (7, N'admin', N'Administrator2', N'admin2@mail.ru', 0x0D5399508427CE79556CDA71918020C1E8D15B53)
INSERT [dbo].[Users] ([PK_UserID], [Status], [Nickname], [Email], [Password]) VALUES (8, N'user', N'User222', N'user2@mail.ru', 0x0D5399508427CE79556CDA71918020C1E8D15B53)
SET IDENTITY_INSERT [dbo].[Users] OFF
/****** Object:  Index [UQ__BlockedU__00684B4431B17721]    Script Date: 11.09.2017 10:39:04 ******/
ALTER TABLE [dbo].[BlockedUsers] ADD  CONSTRAINT [UQ__BlockedU__00684B4431B17721] UNIQUE NONCLUSTERED 
(
	[FK_UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__Tags__2CB6506EC98D66EF]    Script Date: 11.09.2017 10:39:04 ******/
ALTER TABLE [dbo].[Tags] ADD  CONSTRAINT [UQ__Tags__2CB6506EC98D66EF] UNIQUE NONCLUSTERED 
(
	[TagText] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
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
/****** Object:  StoredProcedure [dbo].[AddArticle]    Script Date: 11.09.2017 10:39:04 ******/
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
/****** Object:  StoredProcedure [dbo].[AddComment]    Script Date: 11.09.2017 10:39:04 ******/
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
/****** Object:  StoredProcedure [dbo].[AddRating]    Script Date: 11.09.2017 10:39:04 ******/
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
/****** Object:  StoredProcedure [dbo].[AddTag]    Script Date: 11.09.2017 10:39:04 ******/
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
/****** Object:  StoredProcedure [dbo].[AddTagRelation]    Script Date: 11.09.2017 10:39:04 ******/
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
/****** Object:  StoredProcedure [dbo].[AddUser]    Script Date: 11.09.2017 10:39:04 ******/
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
/****** Object:  StoredProcedure [dbo].[AuthUser]    Script Date: 11.09.2017 10:39:04 ******/
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
/****** Object:  StoredProcedure [dbo].[BlockUser]    Script Date: 11.09.2017 10:39:04 ******/
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
/****** Object:  StoredProcedure [dbo].[ChageArticleStatus]    Script Date: 11.09.2017 10:39:04 ******/
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
/****** Object:  StoredProcedure [dbo].[ChangeUserStatus]    Script Date: 11.09.2017 10:39:04 ******/
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
/****** Object:  StoredProcedure [dbo].[CheckSession]    Script Date: 11.09.2017 10:39:04 ******/
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
/****** Object:  StoredProcedure [dbo].[CheckUserStatus]    Script Date: 11.09.2017 10:39:04 ******/
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
/****** Object:  StoredProcedure [dbo].[CheckUserVote]    Script Date: 11.09.2017 10:39:04 ******/
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
/****** Object:  StoredProcedure [dbo].[CreateSession]    Script Date: 11.09.2017 10:39:04 ******/
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
/****** Object:  StoredProcedure [dbo].[DeleteArticle]    Script Date: 11.09.2017 10:39:04 ******/
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
/****** Object:  StoredProcedure [dbo].[DeleteComment]    Script Date: 11.09.2017 10:39:04 ******/
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
/****** Object:  StoredProcedure [dbo].[DeleteSession]    Script Date: 11.09.2017 10:39:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteSession]
	@UserId int
AS
	DELETE FROM [dbo].[Sessions] WHERE [FK_UserID] = @UserId

GO
/****** Object:  StoredProcedure [dbo].[DeleteUselessTags]    Script Date: 11.09.2017 10:39:04 ******/
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
/****** Object:  StoredProcedure [dbo].[GetAllArticles]    Script Date: 11.09.2017 10:39:04 ******/
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
/****** Object:  StoredProcedure [dbo].[GetArticle]    Script Date: 11.09.2017 10:39:04 ******/
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
/****** Object:  StoredProcedure [dbo].[GetArticleByTag]    Script Date: 11.09.2017 10:39:04 ******/
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
/****** Object:  StoredProcedure [dbo].[GetArticleByText]    Script Date: 11.09.2017 10:39:04 ******/
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
/****** Object:  StoredProcedure [dbo].[GetBlockedArticles]    Script Date: 11.09.2017 10:39:04 ******/
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
/****** Object:  StoredProcedure [dbo].[GetBlockUser]    Script Date: 11.09.2017 10:39:04 ******/
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
/****** Object:  StoredProcedure [dbo].[GetComments]    Script Date: 11.09.2017 10:39:04 ******/
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
/****** Object:  StoredProcedure [dbo].[GetTag]    Script Date: 11.09.2017 10:39:04 ******/
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
/****** Object:  StoredProcedure [dbo].[GetTags]    Script Date: 11.09.2017 10:39:04 ******/
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
/****** Object:  StoredProcedure [dbo].[GetUserArticles]    Script Date: 11.09.2017 10:39:04 ******/
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
/****** Object:  StoredProcedure [dbo].[GetUserByNick]    Script Date: 11.09.2017 10:39:04 ******/
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
/****** Object:  StoredProcedure [dbo].[GetUserId]    Script Date: 11.09.2017 10:39:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetUserId]
	@Email nvarchar(50)
AS
	SELECT [PK_UserID] FROM [dbo].[Users] WHERE [Email] = @Email

GO
/****** Object:  StoredProcedure [dbo].[GetUserIdByNick]    Script Date: 11.09.2017 10:39:04 ******/
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
/****** Object:  StoredProcedure [dbo].[GetUserInfo]    Script Date: 11.09.2017 10:39:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetUserInfo]
	@UserId int
AS
	SELECT [PK_UserID], [Status], [Nickname], [Email] FROM [dbo].[Users] WHERE [PK_UserID] = @UserId

GO
/****** Object:  StoredProcedure [dbo].[UnBlockUser]    Script Date: 11.09.2017 10:39:04 ******/
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
