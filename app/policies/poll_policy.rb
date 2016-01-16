class PollPolicy < ApplicationPolicy
  def index?
    true
  end

  def show_current?
    true
  end

  def show?
    true
  end

  def start?
    record.course.user_id == user.id
  end 

  def stop?
    record.course.user_id == user.id
  end

  def create?
    record.course.user_id == user.id
  end

  def show_response?
    true
  end

  def set_response?
    true
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
