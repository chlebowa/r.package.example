package_name <- desc::desc_get_field("Package")
package_version <- as.character(desc::desc_get_version())

is_new_dev <- endsWith(package_version, "9000")

path <- "NEWS.md"
file_contents <- suppressWarnings(readLines(path))
where_title <- grep(package_name, file_contents)[1L]

if (is_new_dev) {
  file_contents |>
    append(
      values = c(sprintf("# %s %s", package_name, package_version), ""),
      after = where_title - 1L
    ) |>
    writeLines(con = path)
} else {
  file_contents[-where_title] |>
    append(
      values = sprintf("# %s %s", package_name, package_version),
      after = where_title -1L
    ) |>
    writeLines(con = path)
}
