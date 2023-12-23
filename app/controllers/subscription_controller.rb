class SubscriptionController < ApplicationController
  # ���������� ��������
  def subscriptions
    @user = current_user
    subscriptions = User.joins(:subscriptions).where(subscriptions: { follower_id: @user.id })
    render json: subscriptions
  end

  # ���������� �����������
  def subscribers
    @user = current_user
    subscribers = User.joins(:subscribers).where(subscriptions: { follow_id: @user.id })
    render json: subscribers
  end

  # ����������� �����
  def subscribe
    @user = current_user
    @subscription = Subscription.new(follower_id: @user, follow_id: User.find_by(id: params[:id]))
    @subscription.save
    @id = params[:id]
    render json: {
      subscriptions: @subscription
    }
  end

  def unsubscribe
    @user = current_user
    @follow = User.find(params[:id])
    @subscription = Subscription.where(follower_id: @user.id, follow_id: @follow.id)
    @subscription.delete_all
    render json: {
      subscriptions: @follow
    }
  end

  def is_user_subscribed
    @user = current_user
    render json: Subscription.where(follower_id: @user.id, follow_id: params[:id]).exists?
  end

end
