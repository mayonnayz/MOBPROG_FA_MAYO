# Match-a-Biome

## About the App

**Match-a-Biome** is a Minecraft biome recommendation app that helps players discover biomes based on their personal preferences. Users can take a short quiz to find matching biomes and explore detailed information about each biome, including its terrain features, unique blocks, spawning mobs, structures, temperature, and other characteristics.

## API Used

This application uses the **[Astroworld API](https://api.astroworldmc.com/)**, a free public API that provides Minecraft-related data in JSON format.

- **API Endpoint:** `https://api.astroworldmc.com/api/v1/biomes`
- **Documentation:** https://api.astroworldmc.com/
- **HTTP Method:** GET
- **Data Retrieved:** Biome names, dimensions, categories, temperatures, precipitation, terrain features, unique blocks, spawning mobs, structures, colors, rarity, and other information.
- **Filters Used:** Dimension, category, and rarity.

The application uses the API to retrieve biome information and recommend matching biomes based on the user's quiz answers. It also allows users to browse all available biomes and filter the results.

## API Key

The Astroworld API does not require an API key, account registration, or authentication. The application connects directly to the API using HTTP GET requests, so there is no API key stored in the project files.

Biome data is provided by [Astroworld API](https://api.astroworldmc.com/).