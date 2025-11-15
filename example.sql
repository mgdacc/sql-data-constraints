-- Borra las tablas si ya existen para un inicio limpio (opcional)
DROP TABLE IF EXISTS Libros;
DROP TABLE IF EXISTS Autores;

-- Comando necesario para trabajar con FOREIGN KEYS en SQLite.
PRAGMA foreign_keys = ON;

CREATE TABLE Autores (
    AutorID INT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Pais VARCHAR(50)
);

CREATE TABLE Libros (
    LibroID INT PRIMARY KEY,
    Titulo VARCHAR(255) NOT NULL,
    AñoPublicacion INT CHECK (AñoPublicacion > 1500),
    AutorID INT,
    FOREIGN KEY (AutorID) REFERENCES Autores(AutorID)
);

INSERT INTO Autores (AutorID, Nombre, Email, Pais) VALUES
(1, 'Gabriel García Márquez', 'gabo@email.com', 'Colombia'),
(2, 'Isabel Allende', 'isabel@email.com', 'Chile');

INSERT INTO Libros (LibroID, Titulo, AñoPublicacion, AutorID) VALUES
(101, 'Cien años de soledad', 1967, 1),
(102, 'La casa de los espíritus', 1982, 2);

/***** Ejemplo 1: Predecir el Error *****/

/*** ¿Cuál de los siguientes intentos lanzará un mensaje de error? ***/

-- Intento 1
INSERT INTO Autores (AutorID, Nombre, Email, Pais)
VALUES (3, 'Jorge Luis Borges', 'isabel@email.com', 'Argentina');

-- Intento 2
INSERT INTO Libros (LibroID, Titulo, AñoPublicacion, AutorID)
VALUES (103, 'Ficciones', 1944, 5);

-- Intento 3
INSERT INTO Libros (LibroID, Titulo, AñoPublicacion, AutorID)
VALUES (104, NULL, 1955, 1);

-- Intento 4
INSERT INTO Libros (LibroID, Titulo, AñoPublicacion, AutorID)
VALUES (105, 'El Aleph', 1499, 1);

/* El intento 1 fallará porque el email que se intenta registrar ya está registrado en la base de datos y este está protegido por NOT NULL UNIQUE. */
/* El intento 2 fallará porque no existe el autor con el número de ID 5. */
/* El intento 3 fallará porque el título de un libro no puede estar vacío (es decir, no puede ser NULL). */
/* El intento 4 fallará porque el año de publicación es de 1499 y debe ser mayor a 1500. */

/***** Ejemplo 2: Construir una tabla con restricciones *****/

CREATE TABLE Editoriales (
    EditorialID INT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL UNIQUE,
    AñoFundacion INT CHECK (AñoFundacion >= 1800),
    Ciudad VARCHAR(100)
);

INSERT INTO Editoriales (EditorialID, Nombre, AñoFundacion, Ciudad)
VALUES (20, 'Editorial Sudamericana', 1939, 'Buenos Aires');