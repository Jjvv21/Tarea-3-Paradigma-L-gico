# Tarea-3-Sistema-Experto ✈️

Este repositorio contiene un **Sistema Experto** para búsqueda de reservaciones de boletos aéreos, desarrollado en **Racket** bajo el paradigma funcional. El sistema utiliza procesamiento de lenguaje natural en español para ofrecer una interfaz conversacional intuitiva.

## 🎯 Objetivo
Desarrollar un sistema experto capaz de:
- Interpretar consultas en lenguaje natural sobre viajes aéreos
- Procesar preferencias de usuarios (origen, destino, aerolínea, clase, presupuesto)
- Recomendar la mejor opción de vuelo según criterios especificados
- Manejar conversaciones interactivas con respuestas contextuales

## 🧠 Características Principales
- **Base de conocimiento**: Grafo con al menos 5 aeropuertos y 10 vuelos
- **Procesamiento de lenguaje natural**:
  - Reconocimiento de palabras clave (origen, destino, aerolíneas, etc.)
  - Gramáticas BNF para análisis sintáctico
  - Manejo de respuestas contextuales cuando faltan datos
- **Motor de inferencia**:
  - Búsqueda de rutas óptimas (más rápidas o económicas)
  - Filtrado por preferencias (clase, aerolínea, presupuesto)
- **Interfaz conversacional** en español

## 🛠️ Tecnologías y Herramientas
- **Lenguaje**: Racket (paradigma funcional)
- **Técnicas**:
  - Gramáticas libres de contexto (BNF)
  - Procesamiento de lenguaje natural básico
  - Algoritmos de búsqueda en grafos
- **Estructuras de datos**: Listas, grafos, árboles de análisis sintáctico

## 📚 Estructura del Proyecto
- `base-datos.rkt`: Hechos y grafo de aeropuertos/vuelos
- `nlp.rkt`: Procesamiento de lenguaje natural (BNF, reconocimiento de patrones)
- `motor-inferencia.rkt`: Lógica de búsqueda y recomendación
- `interfaz.rkt`: Sistema conversacional interactivo
- `main.rkt`: Punto de entrada del programa
- `README.md`: Este archivo

## 📌 Estado del Proyecto
**Funcionalidades completadas**:
- Base de conocimiento de aeropuertos y vuelos
- Reconocimiento básico de intenciones
- Búsqueda de rutas simples

**Próximas mejoras**:
- [ ] Manejo de sinónimos y variaciones lingüísticas
- [ ] Optimización de búsqueda multi-criterio
- [ ] Base de conocimiento ampliable

## 📖 Créditos
Desarrollado por  Julio Varela Venegas, Yerik Chaves Serrano y Gabriel Nuñez Morales como parte del curso de *Paradigmas de Programación* (2025).
