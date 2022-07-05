-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.3.16-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win64
-- HeidiSQL Versión:             10.2.0.5599
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Volcando estructura de base de datos para bdcomandas21
CREATE DATABASE IF NOT EXISTS `bdcomandas21` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `bdcomandas21`;

-- Volcando estructura para tabla bdcomandas21.clases
CREATE TABLE IF NOT EXISTS `clases` (
  `numero` tinyint(4) NOT NULL DEFAULT 0,
  `nombre` varchar(10) DEFAULT NULL,
  `tipo` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`numero`),
  KEY `Índice 2` (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla bdcomandas21.clases: ~10 rows (aproximadamente)
/*!40000 ALTER TABLE `clases` DISABLE KEYS */;
INSERT INTO `clases` (`numero`, `nombre`, `tipo`) VALUES
	(1, 'Tacos', 'cocina'),
	(2, 'Tortas', 'cocina'),
	(3, 'Aguas', 'barra'),
	(4, 'Refrescos', 'barra'),
	(5, 'Cervezas', 'barra'),
	(6, 'Desayunos', 'cocina'),
	(7, 'Comidas', 'cocina'),
	(8, 'Cenas', 'cocina'),
	(9, 'Postres', 'atencion'),
	(10, 'A la Carta', 'cocina');
/*!40000 ALTER TABLE `clases` ENABLE KEYS */;

-- Volcando estructura para tabla bdcomandas21.comandas
CREATE TABLE IF NOT EXISTS `comandas` (
  `servicio` tinyint(4) NOT NULL,
  `fecha` date NOT NULL DEFAULT curdate(),
  `hora` time NOT NULL DEFAULT curtime(),
  `numero` tinyint(4) NOT NULL,
  `producto` varchar(10) NOT NULL,
  `cantidad` tinyint(4) DEFAULT NULL,
  `precio` decimal(10,2) DEFAULT NULL,
  `comentario` varchar(10) DEFAULT NULL,
  `estado` char(1) DEFAULT 'P' COMMENT 'P-En Preparación E-En Entrega F-Finalizado',
  PRIMARY KEY (`servicio`,`fecha`,`numero`,`producto`),
  KEY `FK_comandas_productos` (`producto`),
  CONSTRAINT `FK_comandas_productos` FOREIGN KEY (`producto`) REFERENCES `productos` (`codigo`),
  CONSTRAINT `FK_comandas_servicios` FOREIGN KEY (`servicio`, `fecha`) REFERENCES `servicios` (`numero`, `fecha`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla bdcomandas21.comandas: ~20 rows (aproximadamente)
/*!40000 ALTER TABLE `comandas` DISABLE KEYS */;
/*!40000 ALTER TABLE `comandas` ENABLE KEYS */;

-- Volcando estructura para tabla bdcomandas21.comentarios
CREATE TABLE IF NOT EXISTS `comentarios` (
  `numero` tinyint(4) NOT NULL DEFAULT 0,
  `clase` varchar(10) DEFAULT NULL,
  `descripcion` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`numero`),
  KEY `FK__clases` (`clase`),
  CONSTRAINT `FK__clases` FOREIGN KEY (`clase`) REFERENCES `clases` (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla bdcomandas21.comentarios: ~10 rows (aproximadamente)
/*!40000 ALTER TABLE `comentarios` DISABLE KEYS */;
INSERT INTO `comentarios` (`numero`, `clase`, `descripcion`) VALUES
	(1, 'Tacos', 'Con todo'),
	(2, 'Tacos', 'X Cebolla'),
	(3, 'Tacos', 'X Cilantro'),
	(4, 'Tortas', 'Chipotle'),
	(5, 'Tortas', 'Rajas'),
	(6, 'Tortas', 'Macha'),
	(7, 'Tortas', 'X Chile'),
	(8, 'Tortas', 'X Cebolla'),
	(9, 'Cervezas', 'En Vaso'),
	(10, 'Refrescos', 'X Hielo');
/*!40000 ALTER TABLE `comentarios` ENABLE KEYS */;

-- Volcando estructura para tabla bdcomandas21.mesas
CREATE TABLE IF NOT EXISTS `mesas` (
  `numero` tinyint(4) NOT NULL DEFAULT 0,
  `nombre` varchar(10) DEFAULT NULL,
  `mesero` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`numero`),
  KEY `FK_mesas_usuarios` (`mesero`),
  CONSTRAINT `FK_mesas_usuarios` FOREIGN KEY (`mesero`) REFERENCES `usuarios` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla bdcomandas21.mesas: ~7 rows (aproximadamente)
/*!40000 ALTER TABLE `mesas` DISABLE KEYS */;
INSERT INTO `mesas` (`numero`, `nombre`, `mesero`) VALUES
	(1, 'Mesa 1', NULL),
	(2, 'Mesa 2', NULL),
	(3, 'Mesa 3', NULL),
	(4, 'Mesa 4', NULL),
	(5, 'Mesa 5', NULL),
	(6, 'Mesa 6', NULL),
	(7, 'Mesa 7', NULL);
/*!40000 ALTER TABLE `mesas` ENABLE KEYS */;

-- Volcando estructura para tabla bdcomandas21.productos
CREATE TABLE IF NOT EXISTS `productos` (
  `codigo` varchar(10) NOT NULL,
  `nombre` varchar(10) DEFAULT NULL,
  `precio` decimal(10,2) DEFAULT NULL,
  `clase` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`codigo`),
  KEY `FK_productos_clases` (`clase`),
  CONSTRAINT `FK_productos_clases` FOREIGN KEY (`clase`) REFERENCES `clases` (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla bdcomandas21.productos: ~18 rows (aproximadamente)
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
INSERT INTO `productos` (`codigo`, `nombre`, `precio`, `clase`) VALUES
	('AGHO', 'A Horchara', 15.00, 'Aguas'),
	('AGTA', 'A Tamarind', 15.00, 'Aguas'),
	('BOHE', 'Bohemia', 18.00, 'Cervezas'),
	('CATA', 'Tampiquena', 65.00, 'A la Carta'),
	('CERE', 'Cereal/Lec', 18.00, 'Desayunos'),
	('COMI', 'C Corrida', 40.00, 'Comidas'),
	('GELA', 'Gelatina', 15.00, 'Postres'),
	('HCHO', 'H Chorizo', 30.00, 'Desayunos'),
	('HMEX', 'H Mexicana', 30.00, 'Desayunos'),
	('HOTC', 'HotCakes', 25.00, 'Cenas'),
	('LAGE', 'Lager', 18.00, 'Cervezas'),
	('MODE', 'Modelo', 20.00, 'Cervezas'),
	('NMOD', 'Negra Mode', 22.00, 'Cervezas'),
	('OTPA', 'O Pastor', 25.00, 'Tacos'),
	('OTSU', 'O Suadero', 30.00, 'Tacos'),
	('PAYQ', 'Pay Queso', 15.00, 'Postres'),
	('REFR', 'Refresco', 15.00, 'Refrescos'),
	('TOPA', 'Tor Pastor', 25.00, 'Tortas');
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;

-- Volcando estructura para tabla bdcomandas21.servicios
CREATE TABLE IF NOT EXISTS `servicios` (
  `numero` tinyint(4) NOT NULL DEFAULT 0,
  `fecha` date NOT NULL DEFAULT curdate(),
  `hora` time NOT NULL DEFAULT curtime(),
  `mesa` tinyint(4) NOT NULL DEFAULT 0,
  `mesero` varchar(10) DEFAULT NULL,
  `comensales` tinyint(4) DEFAULT 0,
  `total` decimal(10,2) DEFAULT NULL,
  `cancelada` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`numero`,`fecha`),
  KEY `FK_servicios_usuarios` (`mesero`),
  KEY `FK_servicios_mesas` (`mesa`),
  CONSTRAINT `FK_servicios_mesas` FOREIGN KEY (`mesa`) REFERENCES `mesas` (`numero`),
  CONSTRAINT `FK_servicios_usuarios` FOREIGN KEY (`mesero`) REFERENCES `usuarios` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla bdcomandas21.servicios: ~7 rows (aproximadamente)
/*!40000 ALTER TABLE `servicios` DISABLE KEYS */;
/*!40000 ALTER TABLE `servicios` ENABLE KEYS */;

-- Volcando estructura para tabla bdcomandas21.usuarios
CREATE TABLE IF NOT EXISTS `usuarios` (
  `codigo` varchar(10) NOT NULL,
  `clave` varchar(10) DEFAULT NULL,
  `nombre` varchar(10) DEFAULT NULL,
  `tipo` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla bdcomandas21.usuarios: ~4 rows (aproximadamente)
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` (`codigo`, `clave`, `nombre`, `tipo`) VALUES
	('barman', 'admin', 'benito jua', 'barra'),
	('cocinero', 'admin', 'maria', 'cocina'),
	('mesero', 'admin', 'jhony', 'atencion'),
	('mesero2', 'admin', 'jhnoyy2', 'atencion'),
	('supervisor', 'admin', 'jaor', 'control');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
