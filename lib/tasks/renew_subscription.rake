require_relative '../../config/boot'
require_relative '../../config/environment'

namespace :subscriptions do
  desc 'Renew subscriptions'
  task renew: :environment do
    Subscription.active.each do |s|
      if s.payments.last.created_at + 1.month < Time.now
        Subscriptions::RenewSubscription.call({subscription_id: s.id})
      end
    end
  end
end
