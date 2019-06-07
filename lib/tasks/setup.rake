desc 'Populate the DB with fake data'
task setup: %w[
  users:build
  posts:build
]
