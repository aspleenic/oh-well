require 'sinatra'

# Define the comic chapters with their respective pages
COMIC_CHAPTERS = [
  { chapter: '1', folder: 'chapter1', pages: ['OWL001-001.jpg', 'OWL001-002.jpg', 'OWL001-003.jpg', 'OWL001-004.jpg', 'OWL001-005.jpg', 'OWL001-006.jpg', 'OWL001-007.jpg', 'OWL001-008.jpg', 'OWL001-009.jpg', 'OWL001-010.jpg', 'OWL001-011.jpg', 'OWL001-012.jpg'], cover: 'OWL001-cover.jpg' },
  { chapter: '2', folder: 'chapter2', pages: ['OWL002-001.jpg', 'OWL002-002.jpg'], cover: 'OWL002-001.jpg' }
  # Add more chapters here...
]

# Set the number of pages to display per chapter
PAGES_PER_CHAPTER = 10

# Define the route for the index page
get '/' do
  # Get the current chapter and page from query parameters
  current_chapter = params[:chapter].to_i || COMIC_CHAPTERS.length
  current_page = params[:page].to_i || 1

  # Get the latest chapter and cover
  latest_chapter = COMIC_CHAPTERS.last
  latest_cover = latest_chapter[:folder] + '/' + latest_chapter[:cover]

  # Get the first page of the latest chapter
  latest_page = latest_chapter[:pages].first

  # Calculate the previous and next page numbers
  # prev_page = current_page - 1
  # next_page = current_page + 1
  prev_page = [current_page - 1, 1].max
  next_page = [current_page + 1, latest_chapter[:pages].length].min
  
  # Get the first and last pages of the current chapter
  first_page = 1
  last_page = latest_chapter[:pages].length
  

  # Calculate the previous and next chapter numbers
  prev_chapter = current_chapter - 1
  next_chapter = current_chapter + 1

  erb :index, locals: {
    latest_page: latest_chapter[:pages][current_page - 1],
    current_chapter: current_chapter,
    current_page: current_page,
    prev_page: prev_page,
    next_page: next_page,
    prev_chapter: prev_chapter,
    next_chapter: next_chapter,
    first_page: first_page,
    last_page: last_page
  }
end


# Define the route for the archive page
get '/archive' do
  erb :archive, locals: { comic_chapters: COMIC_CHAPTERS }
end

# Define the route for the about page
get '/about' do
  erb :about, locals: { comic_chapters: COMIC_CHAPTERS }
end
