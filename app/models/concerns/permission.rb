module Permission
  extend ActiveSupport::Concern

  attr_reader :editable, :deletable

  def set_permission_for(user)
    @editable = user.present? && (self.user == user)
    @deletable = user.present? && (self.user == user)
  end

  # override
  def attributes
    super.merge(editable: @editable, deletable: @deletable)
  end
end
