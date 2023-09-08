# R Mundy Shiny App

Este repositorio contiene una aplicación Shiny en R llamada "R Mundy" que permite visualizar datos de población y área de diferentes países a lo largo del tiempo.

## Descripción

# R Mundy Shiny App

Este repositorio contiene una aplicación Shiny en R llamada "R Mundy" que permite visualizar datos de población y área de diferentes países a lo largo del tiempo.

## Descripción

La aplicación utiliza datos de población y área de países y se apoya en las siguientes bibliotecas de R para su funcionamiento:

| Paquete           | Descripción                                                                                       |
|-------------------|---------------------------------------------------------------------------------------------------|
| shiny             | Paquete de R para crear aplicaciones web interactivas en R.                                      |
| tidyverse         | Conjunto de paquetes que facilitan la manipulación y visualización de datos en R.               |
| shinythemes       | Paquete que proporciona temas adicionales para personalizar la apariencia de aplicaciones Shiny. |
| ggthemes          | Paquete que ofrece temas adicionales para gráficos generados con ggplot2.                        |
| plotly            | Paquete para crear gráficos interactivos en R.                                                    |
| shinycssloaders   | Paquete que proporciona elementos visuales de carga para aplicaciones Shiny.                      |

La aplicación ofrece cuatro pestañas para visualizar diferentes aspectos de los datos:

1. *Población a lo largo del tiempo:* Permite seleccionar uno o varios países y muestra la evolución de la población desde 1980 hasta 2050 en millones.

2. *Área de países:* Permite seleccionar uno o varios países y muestra la superficie de estos países en kilómetros cuadrados.

3. *Población actual:* Muestra la población actual de diferentes países a partir de 1998 en millones.

4. *Gráfico interactivo de población:* Ofrece un gráfico interactivo de población mundial que se puede explorar.

## Uso

Para utilizar la aplicación, sigue estos pasos:

1. Clona este repositorio o descarga los archivos en tu sistema local.

2. Abre la aplicación en RStudio o desde la consola de R.

3. Instala las bibliotecas necesarias utilizando `install.packages` si aún no están instaladas.

4. Ejecuta la aplicación usando `shiny::runApp()`.

5. Selecciona los países y los parámetros deseados en la aplicación para visualizar los datos.

6. Explora y analiza los gráficos generados.

## Requisitos

Asegúrate de tener las siguientes bibliotecas de R instaladas:

- `shiny`
- `tidyverse`
- `shinythemes`
- `ggthemes`
- `plotly`
- `shinycssloaders`

Puedes instalar estas bibliotecas usando el comando `install.packages()` en R.

## Contribuciones

Las contribuciones a este proyecto son bienvenidas. Si deseas contribuir, sigue estos pasos:

1. Haz un fork de este repositorio.

2. Clona el repositorio en tu sistema local.

3. Realiza tus cambios y mejoras.

4. Envía una solicitud de extracción (pull request) explicando tus cambios y por qué deberían ser incorporados
