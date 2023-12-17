class SubscriptionController < ApplicationController
  # ���������� ��������
  def subscriptions
    @user = current_user
    subscriptions = User.joins(:subscriptions).where(subscriptions: { follower_id: @user.id })
    render json: {
      subscriptions: subscriptions
    }
  end

  # ���������� �����������
  def subscribers
    @user = current_user
    subscribers = User.joins(:subscribers).where(subscriptions: { follow_id: @user.id })
    render json: {
      subscribers: subscribers
    }
  end

  # ����������� �����
  def subscribe
    @user = current_user
    @subscription = Subscription.new(follower_id: @user, follow_id: User.find_by(id: params[:id]))
    @subscription.save
    render json: {
      subscriptions: @subscription
    }
  end
end
