defmodule Sift.Events do
  alias Sift.Schema
  alias Sift.Schema.Field

  alias Sift.Events.Types.{
    Address,
    App,
    Booking,
    Browser,
    CountryCode,
    CurrencyCode,
    Image,
    OrderedFrom,
    PaymentMethod,
    Promotion
  }

  @add_item_to_cart_fields %{
    user_id: %Field{key: "$user_id", union: {:id, 0}, union_required?: true},
    session_id: %Field{key: "$session_id", union: {:id, 1}},
    item: %Field{key: "$item", type: :item},
    browser: %Field{key: "$browser", type: Browser, union: :source},
    app: %Field{key: "$app", type: App, union: :source},
    brand_name: %Field{key: "$brand_name"},
    site_country: %Field{key: "$site_country", type: CountryCode},
    site_domain: %Field{key: "$site_domain"},
    ip: %Field{key: "$ip"},
    time: %Field{key: "$time", type: :integer}
  }

  def add_item_to_cart(params) do
    execute("$add_item_to_cart", params, @add_item_to_cart_fields)
  end

  @add_promotion_fields %{
    user_id: %Field{key: "$user_id", union: {:id, 0}, union_required?: true},
    session_id: %Field{key: "$session_id", union: {:id, 1}},
    promotions: %Field{key: "$promotions", type: {:list, Promotion}},
    browser: %Field{key: "$browser", type: Browser, union: :source},
    app: %Field{key: "$app", type: App, union: :source},
    brand_name: %Field{key: "$brand_name"},
    site_country: %Field{key: "$site_country", type: CountryCode},
    site_domain: %Field{key: "$site_domain"},
    ip: %Field{key: "$ip"},
    time: %Field{key: "$time", type: :integer}
  }

  def add_promotion(params) do
    execute("$add_promotion", params, @add_promotion_fields)
  end

  @chargeback_fields %{
    user_id: %Field{key: "$user_id", union: {:id, 0}, union_required?: true},
    session_id: %Field{key: "$session_id", union: {:id, 1}},
    order_id: %Field{key: "$order_id", required?: true},
    transaction_id: %Field{key: "$transaction_id", required?: true},
    chargeback_state: %Field{
      key: "$chargeback_state",
      type: {:enum, [:received, :accepted, :disputed, :won, :lost]}
    },
    chargeback_reason: %Field{
      key: "$chargeback_state",
      type: {:enum, [:fraud, :duplicate, :product_not_received, :product_unacceptable, :other]}
    },
    ip: %Field{key: "$ip"},
    time: %Field{key: "$time", type: :integer}
  }

  def chargeback(params) do
    execute("$chargeback", params, @chargeback_fields)
  end

  @content_status_fields %{
    user_id: %Field{key: "$user_id", union: {:id, 0}, union_required?: true},
    session_id: %Field{key: "$session_id", union: {:id, 1}},
    content_id: %Field{key: "$content_id", required?: true},
    status: %Field{
      key: "$status",
      type: {:enum, [:draft, :pending, :active, :paused, :deleted_by_user, :deleted_by_company]}
    },
    browser: %Field{key: "$browser", type: Browser, union: :source},
    app: %Field{key: "$app", type: App, union: :source},
    brand_name: %Field{key: "$brand_name"},
    site_country: %Field{key: "$site_country", type: CountryCode},
    site_domain: %Field{key: "$site_domain"},
    ip: %Field{key: "$ip"},
    time: %Field{key: "$time", type: :integer}
  }

  def content_status(params) do
    execute("$content_status", params, @content_status_fields)
  end

  @create_account_fields %{
    user_id: %Field{key: "$user_id", required?: true},
    user_email: %Field{key: "$user_email"},
    name: %Field{key: "$name"},
    phone: %Field{key: "$phone"},
    referrer_user_id: %Field{key: "$referrer_user_id"},
    payment_methods: %Field{key: "$payment_methods", type: {:list, PaymentMethod}},
    billing_address: %Field{key: "$billing_address", type: Address},
    shipping_address: %Field{key: "$shipping_address", type: Address},
    promotions: %Field{key: "$promotions", type: {:list, Promotion}},
    social_sign_on_type: %Field{
      key: "$social_sign_on_type",
      type:
        {:enum,
         [:facebook, :google, :linkedin, :twitter, :yahoo, :microsoft, :amazon, Apple, :other]}
    },
    browser: %Field{key: "$browser", type: Browser, union: :source},
    app: %Field{key: "$app", type: App, union: :source},
    account_types: %Field{key: "$account_types", type: {:list, :string}},
    brand_name: %Field{key: "$brand_name"},
    site_country: %Field{key: "$site_country", type: CountryCode},
    site_domain: %Field{key: "$site_domain"},
    ip: %Field{key: "$ip"},
    time: %Field{key: "$time", type: :integer}
  }

  def create_account(params) do
    execute("$create_account", params, @create_account_fields)
  end

  @comment_object %{
    body: %Field{key: "$body"},
    contact_email: %Field{key: "$contact_email"},
    parent_comment_id: %Field{key: "$parent_comment_id"},
    root_content_id: %Field{key: "$root_content_id"},
    images: %Field{key: "$images", type: {:list, Image}}
  }

  @listing_object %{
    subject: %Field{key: "$subject"},
    body: %Field{key: "$body"},
    contact_email: %Field{key: "$contact_email"},
    contact_address: %Field{key: "$contact_address", type: Address},
    locations: %Field{key: "$locations", type: {:list, Address}},
    listed_items: %Field{key: "$listed_items", type: {:list, :item}},
    images: %Field{key: "$images", type: {:list, Image}},
    expiration_time: %Field{key: "$expiration_time", type: :integer}
  }

  @message_object %{
    subject: %Field{key: "$subject"},
    body: %Field{key: "$body"},
    contact_email: %Field{key: "$contact_email"},
    root_content_id: %Field{key: "$root_content_id"},
    recipient_user_ids: %Field{key: "$recipient_user_ids", type: {:list, :string}},
    images: %Field{key: "$images", type: {:list, Image}}
  }

  @post_object %{
    subject: %Field{key: "$subject"},
    body: %Field{key: "$body"},
    contact_email: %Field{key: "$contact_email"},
    contact_address: %Field{key: "$contact_address", type: Address},
    locations: %Field{key: "$locations", type: {:list, Address}},
    categories: %Field{key: "$categories", type: {:list, :string}},
    images: %Field{key: "$images", type: {:list, Image}},
    expiration_time: %Field{key: "$expiration_time", type: :integer}
  }

  @profile_object %{
    body: %Field{key: "$body"},
    contact_email: %Field{key: "$contact_email"},
    contact_address: %Field{key: "$contact_address", type: Address},
    images: %Field{key: "$images", type: {:list, Image}},
    categories: %Field{key: "$categories", type: {:list, :string}}
  }

  @review_object %{
    subject: %Field{key: "$subject"},
    body: %Field{key: "$body"},
    contact_email: %Field{key: "$contact_email"},
    locations: %Field{key: "$locations", type: {:list, Address}},
    item_reviewed: %Field{key: "$item_reviewed", type: :item},
    reviewed_content_id: %Field{key: "$reviewed_content_id"},
    rating: %Field{key: "$rating", type: :float},
    images: %Field{key: "$images", type: {:list, Image}}
  }

  @create_content_fields %{
    user_id: %Field{key: "$user_id", union: {:id, 0}, union_required?: true},
    session_id: %Field{key: "$session_id", union: {:id, 1}},
    content_id: %Field{key: "$content_id", required?: true},
    status: %Field{
      key: "$status",
      type: {:enum, [:draft, :pending, :active, :paused, :deleted_by_user, :deleted_by_company]}
    },
    browser: %Field{key: "$browser", type: Browser, union: :source},
    app: %Field{key: "$app", type: App, union: :source},
    comment: %Field{key: "$comment", type: @comment_object, union: :content},
    listing: %Field{key: "$listing", type: @listing_object, union: :content},
    message: %Field{key: "$message", type: @message_object, union: :content},
    post: %Field{key: "$post", type: @post_object, union: :content},
    profile: %Field{key: "$profile", type: @profile_object, union: :content},
    review: %Field{key: "$review", type: @review_object, union: :content},
    brand_name: %Field{key: "$brand_name"},
    site_country: %Field{key: "$site_country", type: CountryCode},
    site_domain: %Field{key: "$site_domain"},
    ip: %Field{key: "$ip"},
    time: %Field{key: "$time", type: :integer}
  }

  def create_content(params) do
    execute("$create_content", params, @create_content_fields)
  end

  @create_order_fields %{
    user_id: %Field{key: "$user_id", union: {:id, 0}, union_required?: true},
    session_id: %Field{key: "$session_id", union: {:id, 1}},
    order_id: %Field{key: "$order_id"},
    user_email: %Field{key: "$user_email"},
    amount: %Field{key: "$amount", type: :integer},
    currency_code: %Field{key: "$currency_code", type: CurrencyCode},
    billing_address: %Field{key: "$billing_address", type: Address},
    payment_methods: %Field{key: "$payment_methods", type: {:list, PaymentMethod}},
    shipping_address: %Field{key: "$shipping_address", type: Address},
    expedited_shipping: %Field{key: "$expedited_shipping", type: :boolean},
    items: %Field{key: "$items", type: {:list, :item}, union: :items_or_bookings},
    bookings: %Field{key: "$bookings", type: {:list, Booking}, union: :items_or_bookings},
    seller_user_id: %Field{key: "$seller_user_id"},
    promotions: %Field{key: "$promotions", type: {:list, Promotion}},
    shipping_method: %Field{key: "$shipping_method", type: {:enum, [:electronic, :physical]}},
    shipping_carrier: %Field{key: "$shipping_carrier"},
    shipping_tracking_number: %Field{key: "$shipping_tracking_number"},
    ordered_from: %Field{key: "$ordered_from", type: OrderedFrom},
    browser: %Field{key: "$browser", type: Browser, union: :source},
    app: %Field{key: "$app", type: App, union: :source},
    brand_name: %Field{key: "$brand_name"},
    site_country: %Field{key: "$site_country", type: CountryCode},
    site_domain: %Field{key: "$site_domain"},
    ip: %Field{key: "$ip"},
    time: %Field{key: "$time", type: :integer}
  }

  def create_order(params) do
    execute("$create_order", params, @create_order_fields)
  end

  @flag_content_fields %{
    user_id: %Field{key: "$user_id", union: {:id, 0}, union_required?: true},
    session_id: %Field{key: "$session_id", union: {:id, 1}},
    content_id: %Field{key: "$content_id", required?: true},
    flagged_by: %Field{key: "$flagged_by"},
    reason: %Field{
      key: "$reason",
      type:
        {:enum,
         [:toxic, :irrelevant, :commercial, :phishing, :private, :scam, :copyright, :other]}
    },
    ip: %Field{key: "$ip"},
    time: %Field{key: "$time", type: :integer}
  }

  def flag_content(params) do
    execute("$flag_content", params, @flag_content_fields)
  end

  @link_session_to_user_fields %{
    user_id: %Field{key: "$user_id", required?: true},
    session_id: %Field{key: "$session_id", required?: true}
  }

  def link_session_to_user(params) do
    execute("$link_session_to_user", params, @link_session_to_user_fields)
  end

  @login_fields %{
    user_id: %Field{key: "$user_id", union: {:id, 0}, union_required?: true},
    session_id: %Field{key: "$session_id", union: {:id, 1}},
    login_status: %Field{key: "$login_status", type: {:enum, [:success, :failure]}},
    user_email: %Field{key: "$user_email"},
    browser: %Field{key: "$browser", type: Browser, union: :source},
    app: %Field{key: "$app", type: App, union: :source},
    failure_reason: %Field{
      key: "$failure_reason",
      type: {:enum, [:account_unknown, :account_suspended, :account_disabled, :wrong_password]}
    },
    username: %Field{key: "$username"},
    social_sign_on_type: %Field{
      key: "$social_sign_on_type",
      type: {:enum, [:facebook, :google, :linkedin, :twitter, :yahoo, :microsoft, Apple, :other]}
    },
    account_types: %Field{key: "$account_types", type: {:list, :string}},
    brand_name: %Field{key: "$brand_name"},
    site_country: %Field{key: "$site_country", type: CountryCode},
    site_domain: %Field{key: "$site_domain"},
    ip: %Field{key: "$ip"},
    time: %Field{key: "$time", type: :integer}
  }

  def login(params) do
    execute("$login", params, @login_fields)
  end

  @logout_fields %{
    user_id: %Field{key: "$user_id", union: {:id, 0}, union_required?: true},
    session_id: %Field{key: "$session_id", union: {:id, 1}},
    browser: %Field{key: "$browser", type: Browser, union: :source},
    app: %Field{key: "$app", type: App, union: :source},
    brand_name: %Field{key: "$brand_name"},
    site_country: %Field{key: "$site_country"},
    site_domain: %Field{key: "$site_domain"},
    ip: %Field{key: "$ip"},
    time: %Field{key: "$time", type: :integer}
  }

  def logout(params) do
    execute("$logout", params, @logout_fields)
  end

  @order_status_fields %{
    user_id: %Field{key: "$user_id", union: {:id, 0}, union_required?: true},
    session_id: %Field{key: "$session_id", union: {:id, 1}},
    order_id: %Field{key: "$order_id", required?: true},
    order_status: %Field{
      key: "$order_status",
      required?: true,
      type: {:enum, [Approved, :canceled, :held, :fulfilled, :returned]}
    },
    reason: %Field{key: "$reason", type: {:enum, [:payment_risk, :abuse, :policy, :other]}},
    source: %Field{key: "$source", type: {:enum, [:automated, :manual_review]}},
    analyst: %Field{key: "$analyst"},
    webhook_id: %Field{key: "$webhook_id"},
    description: %Field{key: "$description"},
    browser: %Field{key: "$browser", type: Browser, union: :source},
    app: %Field{key: "$app", type: App, union: :source},
    brand_name: %Field{key: "$brand_name"},
    site_country: %Field{key: "$site_country", type: CountryCode},
    site_domain: %Field{key: "$site_domain"},
    ip: %Field{key: "$ip"},
    time: %Field{key: "$time", type: :integer}
  }

  def order_status(params) do
    execute("$order_status", params, @order_status_fields)
  end

  @remove_item_from_cart_fields %{
    user_id: %Field{key: "$user_id", union: {:id, 0}, union_required?: true},
    session_id: %Field{key: "$session_id", union: {:id, 1}},
    item: %Field{key: "$item", type: :item},
    browser: %Field{key: "$browser", type: Browser, union: :source},
    app: %Field{key: "$app", type: App, union: :source},
    brand_name: %Field{key: "$brand_name"},
    site_country: %Field{key: "$site_country", type: CountryCode},
    site_domain: %Field{key: "$site_domain"},
    ip: %Field{key: "$ip"},
    time: %Field{key: "$time", type: :integer}
  }

  def remove_item_from_cart(params) do
    execute("$remove_item_from_cart", params, @remove_item_from_cart_fields)
  end

  @security_notification_fields %{
    user_id: %Field{key: "$user_id", union: {:id, 0}, union_required?: true},
    session_id: %Field{key: "$session_id", union: {:id, 1}},
    notification_type: %Field{key: "$notification_type", type: {:enum, [:email, :sms, :push]}},
    notified_value: %Field{key: "$notified_value"},
    notification_status: %Field{
      key: "$notification_status",
      required?: true,
      type: {:enum, [:sent, :safe, :compromised]}
    },
    browser: %Field{key: "$browser", type: Browser, union: :source},
    app: %Field{key: "$app", type: App, union: :source},
    brand_name: %Field{key: "$brand_name"},
    site_country: %Field{key: "$site_country", type: CountryCode},
    site_domain: %Field{key: "$site_domain"},
    ip: %Field{key: "$ip"},
    time: %Field{key: "$time", type: :integer}
  }

  def security_notification(params) do
    execute("$security_notification", params, @security_notification_fields)
  end

  @transaction_fields %{
    user_id: %Field{key: "$user_id", union: {:id, 0}, union_required?: true},
    session_id: %Field{key: "$session_id", union: {:id, 1}},
    user_email: %Field{key: "$user_email"},
    transaction_type: %Field{
      key: "$transaction_type",
      required?: true,
      type:
        {:enum, [:sale, :authorize, :capture, :void, :refund, :deposit, :withdrawal, :transfer]}
    },
    transaction_status: %Field{
      key: "$transaction_status",
      type: {:enum, [:success, :failure, :pending]}
    },
    amount: %Field{key: "$amount", required?: true, type: :integer},
    currency_code: %Field{key: "$currency_code", required?: true, type: CurrencyCode},
    order_id: %Field{key: "$order_id"},
    transaction_id: %Field{key: "$transaction_id"},
    billing_address: %Field{key: "$billing_address", type: Address},
    payment_method: %Field{key: "$payment_method", type: PaymentMethod},
    shipping_address: %Field{key: "$shipping_address", type: Address},
    transfer_recipient_user_id: %Field{key: "$transfer_recipient_user_id"},
    decline_category: %Field{
      key: "$decline_category",
      type:
        {:enum,
         [
           :fraud,
           :lost_or_stolen,
           :risky,
           :bank_decline,
           :invalid,
           :expired,
           :insufficient_funds,
           :limit_exceeded,
           :additional_verification_required,
           :invalid_verification,
           :other
         ]}
    },
    ordered_from: %Field{key: "$ordered_from", type: OrderedFrom},
    browser: %Field{key: "$browser", type: Browser, union: :source},
    app: %Field{key: "$app", type: App, union: :source},
    brand_name: %Field{key: "$brand_name"},
    site_country: %Field{key: "$site_country", type: CountryCode},
    site_domain: %Field{key: "$site_domain"},
    ip: %Field{key: "$ip"},
    time: %Field{key: "$time", type: :integer}
  }

  def transaction(params) do
    execute("$transaction", params, @transaction_fields)
  end

  @update_account_fields %{
    user_id: %Field{key: "$user_id", union: {:id, 0}, union_required?: true},
    session_id: %Field{key: "$session_id", union: {:id, 1}},
    changed_password: %Field{key: "$changed_password", type: :boolean},
    user_email: %Field{key: "$user_email"},
    name: %Field{key: "$name"},
    phone: %Field{key: "$phone"},
    referrer_user_id: %Field{key: "$referrer_user_id"},
    payment_methods: %Field{key: "$payment_methods", type: {:list, PaymentMethod}},
    billing_address: %Field{key: "$billing_address", type: Address},
    shipping_address: %Field{key: "$shipping_address", type: Address},
    social_sign_on_type: %Field{
      key: "$social_sign_on_type",
      type:
        {:enum,
         [:facebook, :google, :linkedin, :twitter, :yahoo, :microsoft, :amazon, Apple, :other]}
    },
    browser: %Field{key: "$browser", type: Browser, union: :source},
    app: %Field{key: "$app", type: App, union: :source},
    account_types: %Field{key: "$account_types", type: {:list, :string}},
    brand_name: %Field{key: "$brand_name"},
    site_country: %Field{key: "$site_country", type: CountryCode},
    site_domain: %Field{key: "$site_domain"},
    ip: %Field{key: "$ip"},
    time: %Field{key: "$time", type: :integer}
  }

  def update_account(params) do
    execute("$update_account", params, @update_account_fields)
  end

  @update_content_fields @create_content_fields

  def update_content(params) do
    execute("$update_content", params, @update_content_fields)
  end

  @update_order_fields @create_order_fields

  def update_order(params) do
    execute("$update_order", params, @update_order_fields)
  end

  @update_password_fields %{
    user_id: %Field{key: "$user_id", union: {:id, 0}, union_required?: true},
    session_id: %Field{key: "$session_id", union: {:id, 1}},
    reason: %Field{
      key: "$reason",
      required?: true,
      type: {:enum, [:user_update, :forgot_password, :forced_reset]}
    },
    status: %Field{key: "$status", required?: true, type: {:enum, [:pending, :success, :failure]}},
    browser: %Field{key: "$browser", type: Browser, union: :source},
    app: %Field{key: "$app", type: App, union: :source},
    brand_name: %Field{key: "$brand_name"},
    site_country: %Field{key: "$site_country", type: CountryCode},
    site_domain: %Field{key: "$site_domain"},
    ip: %Field{key: "$ip"},
    time: %Field{key: "$time", type: :integer}
  }

  def update_password(params) do
    execute("$update_password", params, @update_password_fields)
  end

  @verification_fields %{
    user_id: %Field{key: "$user_id", required?: true},
    session_id: %Field{key: "$session_id", required?: true},
    status: %Field{key: "$status", required?: true, type: {:enum, [:pending, :success, :failure]}},
    verified_event: %Field{
      key: "$verified_event",
      type:
        {:enum,
         [
           :login,
           :create_account,
           :update_account,
           :update_password,
           :create_content,
           :create_order,
           :transaction,
           :update_content,
           :update_order
         ]}
    },
    verified_entity_id: %Field{key: "$verified_entity_id"},
    verification_type: %Field{
      key: "$verification_type",
      type:
        {:enum,
         [
           :sms,
           :phone_call,
           :email,
           App_tfa,
           :captcha,
           :shared_knowledge,
           :face,
           :fingerprint,
           :push,
           :security_key
         ]}
    },
    verified_value: %Field{key: "$verified_value"},
    reason: %Field{
      key: "$reason",
      required?: true,
      type: {:enum, [:user_setting, :manual_review, :automated_rule]}
    },
    browser: %Field{key: "$browser", type: Browser, union: :source},
    app: %Field{key: "$app", type: App, union: :source},
    brand_name: %Field{key: "$brand_name"},
    site_country: %Field{key: "$site_country", type: CountryCode},
    site_domain: %Field{key: "$site_domain"},
    ip: %Field{key: "$ip"},
    time: %Field{key: "$time", type: :integer}
  }

  def verification(params) do
    execute("$verification", params, @verification_fields)
  end

  defp execute(event_name, params, specs) do
    with {:ok, parsed} <- Schema.parse(params, specs),
         payload <- Map.put(parsed, "$type", event_name) do
      {:ok, payload}
    else
      error -> error
    end
  end
end
