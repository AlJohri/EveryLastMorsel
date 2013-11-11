class NotificationStore
  def self.add(notification)
    @notifications ||= []
    @notifications << notification
  end

  def self.notifications
    @notifications || []
  end

  def self.clear
    @notifications = []
  end
end
