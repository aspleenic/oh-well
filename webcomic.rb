require 'sinatra'

# Define the comic chapters with their respective pages
COMIC_CHAPTERS = [
  { chapter: 'Chapter 1', pages: ['OWL001-01.jpg', 'OWL001-02.jpg', 'OWL001-03.jpg'] },
  # { chapter: 'Chapter 2', pages: ['page2-1.jpg', 'page2-2.jpg', 'page2-3.jpg'] },
  # Add more chapters here...
]

# Set the number of pages to display per chapter
PAGES_PER_CHAPTER = 1

# Define the route for the index page
get '/' do
  # Get the current chapter and page from query parameters
  current_chapter = params[:chapter].to_i || COMIC_CHAPTERS.length
  current_page = params[:page].to_i || COMIC_CHAPTERS[current_chapter - 1][:pages].length

  # Get the latest chapter
  latest_chapter = COMIC_CHAPTERS.last

  # Get the first page of the latest chapter
  latest_page = latest_chapter[:pages].first

  # Calculate the previous and next page numbers
  prev_page = current_page - 1
  next_page = current_page + 1

  # Calculate the previous and next chapter numbers
  prev_chapter = current_chapter - 1
  next_chapter = current_chapter + 1

  erb :index, locals: {
    latest_page: latest_page,
    current_chapter: current_chapter,
    current_page: current_page,
    prev_page: prev_page,
    next_page: next_page,
    prev_chapter: prev_chapter,
    next_chapter: next_chapter
  }
end

# Define the route for the archive page
get '/archive' do
  erb :archive, locals: { comic_chapters: COMIC_CHAPTERS }
end
