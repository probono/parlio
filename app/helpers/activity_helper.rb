module ActivityHelper 
  def current_sessions_date
    Intervention.all.map{|i| i.session_date}.uniq.sort.reverse
  end
end
