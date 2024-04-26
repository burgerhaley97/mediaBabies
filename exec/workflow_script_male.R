# Set configuration values
percent_change_cutoff <- 100
max_influence_year_range <- 2

# Load the datasets
data("characters")
data("male_babies")

# Filter characters by babies and babies by characters
m_chars_filtered <- filter_char_by_baby_names(characters, male_babies)
m_babies_filtered <- filter_baby_names_by_char(male_babies, characters)

# Filter babies by names atypical of that sex
m_babies_filtered <- filter_baby_names_by_names(m_babies_filtered,
                                                female_babies)

# Create percent change and point of interest tables
m_babies_pc <- create_percent_change_df(m_babies_filtered)
m_babies_poi <- create_poi_df(m_babies_pc, percent_change_cutoff)

# Create table of media-influenced names for both males and females
m_media_names <- create_media_names_df(m_babies_poi,
                                       m_chars_filtered,
                                       max_influence_year_range)

# Make list of unique names
m_unique_names <- unique(m_media_names$name)

# (Optional) Get totals and max counts for females
subset_m <- m_babies_filtered[, names(m_babies_filtered) %in% m_unique_names]
m_sums <- colSums(subset_m)
m_max <- apply(subset_m, 2, max)
m_sum_max <- data.frame(sum = as.numeric(m_sums), max = as.numeric(m_max))
rownames(m_sum_max) <- names(subset_m)
m_sum_max <- m_sum_max[order(-m_sum_max$max), ]

# Plot a name
start_year <- as.numeric(rownames(m_babies_filtered)[1])
gender <- "m"
name <- "Leonidas"
name_influences <- influences(m_media_names[m_media_names$name == name, ])
name_counts <- baby_count(name, start_year, m_babies_filtered[[name]])
name_pcs <- baby_pc(name, start_year, m_babies_pc[[name]])

plot(name_influences, name_counts, "male")
