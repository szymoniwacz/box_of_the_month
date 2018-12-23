require_relative '../../config/boot'
require_relative '../../config/environment'

namespace :subscriptions do
  desc 'Renew subscriptions'
  task renew: :environment do
    Subscription.active.each do |s|
      Subscriptions::RenewSubscription.call(subscription_id: s.id) if s.payments.last.created_at + 1.month < Time.now
    end
  end
end
