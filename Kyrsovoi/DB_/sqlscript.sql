USE [master]
GO
/****** Object:  Database [Colleg]    Script Date: 17-Mar-24 2:32:20 PM ******/
CREATE DATABASE [Colleg]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Colleg', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\Colleg.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Colleg_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\Colleg_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Colleg] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Colleg].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Colleg] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Colleg] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Colleg] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Colleg] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Colleg] SET ARITHABORT OFF 
GO
ALTER DATABASE [Colleg] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Colleg] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Colleg] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Colleg] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Colleg] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Colleg] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Colleg] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Colleg] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Colleg] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Colleg] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Colleg] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Colleg] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Colleg] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Colleg] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Colleg] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Colleg] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Colleg] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Colleg] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Colleg] SET  MULTI_USER 
GO
ALTER DATABASE [Colleg] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Colleg] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Colleg] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Colleg] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Colleg] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Colleg] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Colleg] SET QUERY_STORE = ON
GO
ALTER DATABASE [Colleg] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Colleg]
GO
/****** Object:  Table [dbo].[Время_занятий]    Script Date: 17-Mar-24 2:32:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Время_занятий](
	[День] [varchar](10) NOT NULL,
	[Id_кабинета] [int] NOT NULL,
	[Id_расписания] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[День] ASC,
	[Id_кабинета] ASC,
	[Id_расписания] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Группа]    Script Date: 17-Mar-24 2:32:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Группа](
	[Id_группы] [int] NOT NULL,
	[Название_группы] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_группы] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Кабинет]    Script Date: 17-Mar-24 2:32:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Кабинет](
	[Id_кабинета] [int] NOT NULL,
	[Номер] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_кабинета] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Курс]    Script Date: 17-Mar-24 2:32:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Курс](
	[Id_курса] [int] NOT NULL,
	[Название_курса] [varchar](100) NULL,
	[Описание] [text] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_курса] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Предмет]    Script Date: 17-Mar-24 2:32:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Предмет](
	[Id_предмета] [int] NOT NULL,
	[Название_предмета] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_предмета] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Преподаватель]    Script Date: 17-Mar-24 2:32:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Преподаватель](
	[Id_преподавателя] [int] NOT NULL,
	[ФИО] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_преподавателя] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Расписание]    Script Date: 17-Mar-24 2:32:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Расписание](
	[Id_расписания] [int] NOT NULL,
	[Id_группы] [int] NULL,
	[Id_преподавателя] [int] NULL,
	[Id_предмета] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_расписания] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Студенты]    Script Date: 17-Mar-24 2:32:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Студенты](
	[Id_студента] [int] NOT NULL,
	[Имя] [varchar](100) NULL,
	[Id_курса] [int] NULL,
	[Id_группы] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_студента] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Группа] ([Id_группы], [Название_группы]) VALUES (1, N'??-101')
INSERT [dbo].[Группа] ([Id_группы], [Название_группы]) VALUES (2, N'??-201')
GO
INSERT [dbo].[Кабинет] ([Id_кабинета], [Номер]) VALUES (1, N'101')
INSERT [dbo].[Кабинет] ([Id_кабинета], [Номер]) VALUES (2, N'202')
INSERT [dbo].[Кабинет] ([Id_кабинета], [Номер]) VALUES (3, N'305')
GO
INSERT [dbo].[Курс] ([Id_курса], [Название_курса], [Описание]) VALUES (1, N'????????????????', N'???? ?? ??????? ????????????????')
INSERT [dbo].[Курс] ([Id_курса], [Название_курса], [Описание]) VALUES (2, N'???? ??????', N'???? ?? ?????????????? ? ????????????????? ??? ??????')
GO
INSERT [dbo].[Предмет] ([Id_предмета], [Название_предмета]) VALUES (1, N'?????? ????????????????')
INSERT [dbo].[Предмет] ([Id_предмета], [Название_предмета]) VALUES (2, N'???? ?????? SQL')
GO
INSERT [dbo].[Преподаватель] ([Id_преподавателя], [ФИО]) VALUES (1, N'?????? ???? ????????')
INSERT [dbo].[Преподаватель] ([Id_преподавателя], [ФИО]) VALUES (2, N'??????? ???? ??????????')
GO
INSERT [dbo].[Расписание] ([Id_расписания], [Id_группы], [Id_преподавателя], [Id_предмета]) VALUES (1, 1, 1, 1)
INSERT [dbo].[Расписание] ([Id_расписания], [Id_группы], [Id_преподавателя], [Id_предмета]) VALUES (2, 2, 2, 2)
GO
INSERT [dbo].[Студенты] ([Id_студента], [Имя], [Id_курса], [Id_группы]) VALUES (1, N'???? ??????', 1, 1)
INSERT [dbo].[Студенты] ([Id_студента], [Имя], [Id_курса], [Id_группы]) VALUES (2, N'????? ????????', 1, 1)
INSERT [dbo].[Студенты] ([Id_студента], [Имя], [Id_курса], [Id_группы]) VALUES (3, N'?????? ????????', 2, 2)
GO
ALTER TABLE [dbo].[Время_занятий]  WITH CHECK ADD FOREIGN KEY([Id_кабинета])
REFERENCES [dbo].[Кабинет] ([Id_кабинета])
GO
ALTER TABLE [dbo].[Время_занятий]  WITH CHECK ADD FOREIGN KEY([Id_расписания])
REFERENCES [dbo].[Расписание] ([Id_расписания])
GO
ALTER TABLE [dbo].[Расписание]  WITH CHECK ADD FOREIGN KEY([Id_группы])
REFERENCES [dbo].[Группа] ([Id_группы])
GO
ALTER TABLE [dbo].[Расписание]  WITH CHECK ADD FOREIGN KEY([Id_преподавателя])
REFERENCES [dbo].[Преподаватель] ([Id_преподавателя])
GO
ALTER TABLE [dbo].[Расписание]  WITH CHECK ADD FOREIGN KEY([Id_предмета])
REFERENCES [dbo].[Предмет] ([Id_предмета])
GO
ALTER TABLE [dbo].[Студенты]  WITH CHECK ADD FOREIGN KEY([Id_группы])
REFERENCES [dbo].[Группа] ([Id_группы])
GO
ALTER TABLE [dbo].[Студенты]  WITH CHECK ADD FOREIGN KEY([Id_курса])
REFERENCES [dbo].[Курс] ([Id_курса])
GO
USE [master]
GO
ALTER DATABASE [Colleg] SET  READ_WRITE 
GO
