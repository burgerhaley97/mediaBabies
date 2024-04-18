# Set configuration values
sex_imbalance_ratio <- 1
percent_change_cutoff <- 100
max_influence_year_range <- 5

# Load the datasets
data("characters")
data("female_babies")
data("male_babies")

# Filter characters by babies and babies by characters
f_chars_filtered <- filter_char_by_baby_names(characters, female_babies)
m_chars_filtered <- filter_char_by_baby_names(characters, male_babies)
f_babies_filtered <- filter_baby_names_by_char(female_babies, characters)
m_babies_filtered <- filter_baby_names_by_char(male_babies, characters)

# Filter babies by names atypical of that sex
m_babies_filtered <- filter_baby_names_by_names(m_babies_filtered,
                                                female_babies,
                                                sex_imbalance_ratio)
f_babies_filtered <- filter_baby_names_by_names(f_babies_filtered,
                                                male_babies,
                                                sex_imbalance_ratio)

# Create percent change and point of interest tables
f_babies_pc <- create_percent_change_df(f_babies_filtered)
m_babies_pc <- create_percent_change_df(m_babies_filtered)
f_babies_poi <- create_poi_df(f_babies_pc, percent_change_cutoff)
m_babies_poi <- create_poi_df(m_babies_pc, percent_change_cutoff)

# Create table of media-influenced names for both males and females
f_media_names <- create_media_names_df(f_babies_poi,
                                       f_chars_filtered,
                                       max_influence_year_range)
m_media_names <- create_media_names_df(m_babies_poi,
                                       m_chars_filtered,
                                       max_influence_year_range)

# Make list of unique names
f_unique_names <- unique(f_media_names$name)
m_unique_names <- unique(m_media_names$name)
