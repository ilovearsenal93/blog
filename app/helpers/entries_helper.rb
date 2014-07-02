module EntriesHelper
	def current_entry
    @current_entry= Entry.find_by(id: params[:id])
  end
end