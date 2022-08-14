//Get all characters
const String getAllCharacters = """
query allCharacters(\$page: Int!) {
  characters(page: \$page) {
    info {
      count
      pages
      next
    }
    results {
      id
      name
      species
      gender
      image
      created
    }
  }
}
""";

//Get all episodes
const String getAllEpisodes = """
query allEpisodes(\$page: Int!)  {
  episodes(page: \$page) {
    info {
      count
      pages
      next
    }
    results {
      id
      name
      air_date
      episode
      created
    }
  }
}
""";

//Get all locations
final String getAllLocations = """
query allLocations(\$page: Int!) {
  locations(page: \$page) {
    info {
      count
      pages
      next
    }
    results {
      id
      name
      type
      dimension
      created
    }
  }
}
""";

//Get all character details
final String getCharacterDetails = """
  query characterDetails(\$id: ID!) {
  character(id: \$id) {
    id 
    name
    status
    type
    image
    origin {
      name
    }
    episode {
      episode
      id
    }
    location {
      name
      id
    }
  }
}""";

//Get all episode details
final String getEpisodeDetails = """
query episodeDetails(\$id: ID!) {
  episode(id: \$id) {
    id
    name
    air_date
    episode
    characters {
      id
      name
      image
    }
  }
}
""";

//Get all location details
final String getLocationDetails = """
query LocationDetails(\$id: ID!) {
  location(id: \$id) {
    id
    name
    created
    type
    residents {
      id
      name
      image
    }
  }
}
""";
