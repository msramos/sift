defmodule Sift.Events do
  alias Sift.Base
  alias Sift.Base.Field

  @add_item_to_cart_fields %{
    user_id: %Field{key: "$user_id", union: {:id, 0}, union_required?: true},
    session_id: %Field{key: "$session_id", union: {:id, 1}},
    item: %Field{key: "$item", type: :item},
    browser: %Field{key: "$browser", type: :browser, union: :source},
    app: %Field{key: "$app", type: :app, union: :source},
    brand_name: %Field{key: "$brand_name"},
    site_country: %Field{key: "$site_country", type: :country_code},
    site_domain: %Field{key: "$site_domain"},
    ip: %Field{key: "$ip"},
    time: %Field{key: "$time", type: :integer}
  }

  @add_promotion_fields %{
    user_id: %Field{key: "$user_id", union: {:id, 0}, union_required?: true},
    session_id: %Field{key: "$session_id", union: {:id, 1}},
    promotions: %Field{key: "$promotions", type: {:list, :promotion}},
    browser: %Field{key: "$browser", type: :browser, union: :source},
    app: %Field{key: "$app", type: :app, union: :source},
    brand_name: %Field{key: "$brand_name"},
    site_country: %Field{key: "$site_country", type: :country_code},
    site_domain: %Field{key: "$site_domain"},
    ip: %Field{key: "$ip"},
    time: %Field{key: "$time", type: :integer}
  }

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

  @content_status_fields %{
    user_id: %Field{key: "$user_id", union: {:id, 0}, union_required?: true},
    session_id: %Field{key: "$session_id", union: {:id, 1}},
    content_id: %Field{key: "$content_id", required?: true},
    status: %Field{
      key: "$status",
      type: {:enum, [:draft, :pending, :active, :paused, :deleted_by_user, :deleted_by_company]}
    },
    browser: %Field{key: "$browser", type: :browser, union: :source},
    app: %Field{key: "$app", type: :app, union: :source},
    brand_name: %Field{key: "$brand_name"},
    site_country: %Field{key: "$site_country", type: :country_code},
    site_domain: %Field{key: "$site_domain"},
    ip: %Field{key: "$ip"},
    time: %Field{key: "$time", type: :integer}
  }

  @comment_object %{
    body: %Field{key: "$body"},
    contact_email: %Field{key: "$contact_email"},
    parent_comment_id: %Field{key: "$parent_comment_id"},
    root_content_id: %Field{key: "$root_content_id"},
    images: %Field{key: "$images", type: {:list, :image}}
  }

  @listing_object %{
    subject: %Field{key: "$subject"},
    body: %Field{key: "$body"},
    contact_email: %Field{key: "$contact_email"},
    contact_address: %Field{key: "$contact_address", type: :address},
    locations: %Field{key: "$locations", type: {:list, :address}},
    listed_items: %Field{key: "$listed_items", type: {:list, :item}},
    images: %Field{key: "$images", type: {:list, :image}},
    expiration_time: %Field{key: "$expiration_time", type: :integer}
  }

  @message_object %{
    subject: %Field{key: "$subject"},
    body: %Field{key: "$body"},
    contact_email: %Field{key: "$contact_email"},
    root_content_id: %Field{key: "$root_content_id"},
    recipient_user_ids: %Field{key: "$recipient_user_ids", type: {:list, :string}},
    images: %Field{key: "$images", type: {:list, :image}}
  }

  @post_object %{
    subject: %Field{key: "$subject"},
    body: %Field{key: "$body"},
    contact_email: %Field{key: "$contact_email"},
    contact_address: %Field{key: "$contact_address", type: :address},
    locations: %Field{key: "$locations", type: {:list, :address}},
    categories: %Field{key: "$categories", type: {:list, :string}},
    images: %Field{key: "$images", type: {:list, :image}},
    expiration_time: %Field{key: "$expiration_time", type: :integer}
  }

  @profile_object %{
    body: %Field{key: "$body"},
    contact_email: %Field{key: "$contact_email"},
    contact_address: %Field{key: "$contact_address", type: :address},
    images: %Field{key: "$images", type: {:list, :image}},
    categories: %Field{key: "$categories", type: {:list, :string}}
  }

  @review_object %{
    subject: %Field{key: "$subject"},
    body: %Field{key: "$body"},
    contact_email: %Field{key: "$contact_email"},
    locations: %Field{key: "$locations", type: {:list, :address}},
    item_reviewed: %Field{key: "$item_reviewed", type: :item},
    reviewed_content_id: %Field{key: "$reviewed_content_id"},
    rating: %Field{key: "$rating", type: :float},
    images: %Field{key: "$images", type: {:list, :image}}
  }

  @create_content_fields %{
    user_id: %Field{key: "$user_id", union: {:id, 0}, union_required?: true},
    session_id: %Field{key: "$session_id", union: {:id, 1}},
    content_id: %Field{key: "$content_id", required?: true},
    status: %Field{
      key: "$status",
      type: {:enum, [:draft, :pending, :active, :paused, :deleted_by_user, :deleted_by_company]}
    },
    browser: %Field{key: "$browser", type: :browser, union: :source},
    app: %Field{key: "$app", type: :app, union: :source},
    comment: %Field{key: "$comment", type: @comment_object, union: :content},
    listing: %Field{key: "$listing", type: @listing_object, union: :content},
    message: %Field{key: "$message", type: @message_object, union: :content},
    post: %Field{key: "$post", type: @post_object, union: :content},
    profile: %Field{key: "$profile", type: @profile_object, union: :content},
    review: %Field{key: "$review", type: @review_object, union: :content},
    brand_name: %Field{key: "$brand_name"},
    site_country: %Field{key: "$site_country", type: :country_code},
    site_domain: %Field{key: "$site_domain"},
    ip: %Field{key: "$ip"},
    time: %Field{key: "$time", type: :integer}
  }

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

  @logout_fields %{
    user_id: %Field{key: "$user_id", union: {:id, 0}, union_required?: true},
    session_id: %Field{key: "$session_id", union: {:id, 1}},
    browser: %Field{key: "$browser", type: :browser, union: :source},
    app: %Field{key: "$app", type: :app, union: :source},
    brand_name: %Field{key: "$brand_name"},
    site_country: %Field{key: "$site_country"},
    site_domain: %Field{key: "$site_domain"},
    ip: %Field{key: "$ip"},
    time: %Field{key: "$time", type: :integer}
  }

  @login_fields %{
    user_id: %Field{key: "$user_id", union: {:id, 0}, union_required?: true},
    session_id: %Field{key: "$session_id", union: {:id, 1}},
    login_status: %Field{key: "$login_status", type: {:enum, [:success, :failure]}},
    user_email: %Field{key: "$user_email"},
    browser: %Field{key: "$browser", type: :browser, union: :source},
    app: %Field{key: "$app", type: :app, union: :source},
    failure_reason: %Field{
      key: "$failure_reason",
      type: {:enum, [:account_unknown, :account_suspended, :account_disabled, :wrong_password]}
    },
    username: %Field{key: "$username"},
    social_sign_on_type: %Field{
      key: "$social_sign_on_type",
      type: {:enum, [:facebook, :google, :linkedin, :twitter, :yahoo, :microsoft, :apple, :other]}
    },
    account_types: %Field{key: "$account_types", type: {:list, :string}},
    brand_name: %Field{key: "$brand_name"},
    site_country: %Field{key: "$site_country", type: :country_code},
    site_domain: %Field{key: "$site_domain"},
    ip: %Field{key: "$ip"},
    time: %Field{key: "$time", type: :integer}
  }

  def add_item_to_cart(params) do
    Base.execute("$add_item_to_cart", params, @add_item_to_cart_fields)
  end

  def add_promotion(params) do
    Base.execute("$add_promotion", params, @add_promotion_fields)
  end

  def chargeback(params) do
    Base.execute("$chargeback", params, @chargeback_fields)
  end

  def content_status(params) do
    Base.execute("$content_status", params, @content_status_fields)
  end

  def create_content(params) do
    Base.execute("$create_content", params, @create_content_fields)
  end

  def flag_content(params) do
    Base.execute("$flag_content", params, @flag_content_fields)
  end

  def login(params) do
    Base.execute("$login", params, @login_fields)
  end

  def logout(params) do
    Base.execute("$logout", params, @logout_fields)
  end
end
