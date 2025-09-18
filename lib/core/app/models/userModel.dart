// users.dart
// Kullanıcı çekirdeği ve alt koleksiyon modelleri.
// Firestore ile birebir anahtar eşlemesi ve withConverter yardımcıları içerir.

import 'package:cloud_firestore/cloud_firestore.dart';

// -------------------- Enums -------------------- //

enum UserRole { customer, b2b, admin }

enum BillingType { earsiv, efatura }

enum ConsentType { kvkk, tos, marketing }

enum DevicePlatform { ios, android, web }

// -------------------- Utils -------------------- //

DateTime? _toDateTime(dynamic v) {
  if (v is Timestamp) return v.toDate();
  if (v is DateTime) return v;
  return null;
}

Timestamp? _toTimestamp(DateTime? dt) => dt == null ? null : Timestamp.fromDate(dt);

Map<String, dynamic> _nn(Map<String, dynamic> m) {
  // Sadece null alanları kaldır. Boş Map/List değerleri KALIR.
  final out = <String, dynamic>{};
  m.forEach((k, v) {
    if (v != null) out[k] = v;
  });
  return out;
}

// -------------------- Alt Koleksiyon Modelleri -------------------- //

class UserAddress {
  final String id;
  final String? title;
  final String? country;
  final String? city; // il
  final String? district; // ilçe
  final String? neighborhood;
  final String? postalCode;
  final String? addressLine;
  final String? contactName;
  final String? phoneE164;
  final GeoPoint? location;
  final bool isDefaultShipping;
  final bool isDefaultBilling;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const UserAddress({
    required this.id,
    this.title,
    this.country,
    this.city,
    this.district,
    this.neighborhood,
    this.postalCode,
    this.addressLine,
    this.contactName,
    this.phoneE164,
    this.location,
    this.isDefaultShipping = false,
    this.isDefaultBilling = false,
    this.createdAt,
    this.updatedAt,
  });

  factory UserAddress.fromMap(String id, Map<String, dynamic> map) => UserAddress(
        id: id,
        title: map['title'] as String?,
        country: map['country'] as String?,
        city: map['city'] as String?,
        district: map['district'] as String?,
        neighborhood: map['neighborhood'] as String?,
        postalCode: map['postal_code'] as String?,
        addressLine: map['address_line'] as String?,
        contactName: map['contact_name'] as String?,
        phoneE164: map['phone_e164'] as String?,
        isDefaultShipping: (map['is_default_shipping'] ?? false) as bool,
        isDefaultBilling: (map['is_default_billing'] ?? false) as bool,
        createdAt: _toDateTime(map['created_at']),
        updatedAt: _toDateTime(map['updated_at']),
      );

  Map<String, dynamic> toMap() => _nn({
        'title': title,
        'country': country,
        'city': city,
        'district': district,
        'neighborhood': neighborhood,
        'postal_code': postalCode,
        'address_line': addressLine,
        'contact_name': contactName,
        'phone_e164': phoneE164,
        'location': location,
        'is_default_shipping': isDefaultShipping,
        'is_default_billing': isDefaultBilling,
        'created_at': _toTimestamp(createdAt),
        'updated_at': _toTimestamp(updatedAt),
      });

  UserAddress copyWith({
    String? id,
    String? title,
    String? country,
    String? city,
    String? district,
    String? neighborhood,
    String? postalCode,
    String? addressLine,
    String? contactName,
    String? phoneE164,
    bool? isDefaultShipping,
    bool? isDefaultBilling,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      UserAddress(
        id: id ?? this.id,
        title: title ?? this.title,
        country: country ?? this.country,
        city: city ?? this.city,
        district: district ?? this.district,
        neighborhood: neighborhood ?? this.neighborhood,
        postalCode: postalCode ?? this.postalCode,
        addressLine: addressLine ?? this.addressLine,
        contactName: contactName ?? this.contactName,
        phoneE164: phoneE164 ?? this.phoneE164,
        location: location ?? location,
        isDefaultShipping: isDefaultShipping ?? this.isDefaultShipping,
        isDefaultBilling: isDefaultBilling ?? this.isDefaultBilling,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
}

class BillingProfile {
  final String id;
  final BillingType type;
  final String? tckn;
  final String? vkn;
  final String? companyTitle;
  final String? taxOffice;
  final String? mersisNo;
  final String? eInvoiceAlias;
  final bool? eArchive;
  // Adres
  final String? country;
  final String? city;
  final String? district;
  final String? postalCode;
  final String? addressLine;
  final bool isDefaultBilling;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const BillingProfile({
    required this.id,
    required this.type,
    this.tckn,
    this.vkn,
    this.companyTitle,
    this.taxOffice,
    this.mersisNo,
    this.eInvoiceAlias,
    this.eArchive,
    this.country,
    this.city,
    this.district,
    this.postalCode,
    this.addressLine,
    this.isDefaultBilling = false,
    this.createdAt,
    this.updatedAt,
  });

  factory BillingProfile.fromMap(String id, Map<String, dynamic> map) => BillingProfile(
        id: id,
        type: (map['type'] as String) == 'efatura' ? BillingType.efatura : BillingType.earsiv,
        tckn: map['type'] == 'earsiv' ? map['tckn'] as String? : null,
        vkn: map['type'] == 'efatura' ? map['vkn'] as String? : null,
        companyTitle: map['company_title'] as String?,
        taxOffice: map['tax_office'] as String?,
        mersisNo: map['mersis_no'] as String?,
        eInvoiceAlias: map['e_invoice_alias'] as String?,
        eArchive: map['e_archive'] as bool?,
        country: map['country'] as String?,
        city: map['city'] as String?,
        district: map['district'] as String?,
        postalCode: map['postal_code'] as String?,
        addressLine: map['address_line'] as String?,
        isDefaultBilling: (map['is_default_billing'] ?? false) as bool,
        createdAt: _toDateTime(map['created_at']),
        updatedAt: _toDateTime(map['updated_at']),
      );

  Map<String, dynamic> toMap() => _nn({
        'type': type == BillingType.efatura ? 'efatura' : 'earsiv',
        'tckn': tckn,
        'vkn': vkn,
        'company_title': companyTitle,
        'tax_office': taxOffice,
        'mersis_no': mersisNo,
        'e_invoice_alias': eInvoiceAlias,
        'e_archive': eArchive,
        'country': country,
        'city': city,
        'district': district,
        'postal_code': postalCode,
        'address_line': addressLine,
        'is_default_billing': isDefaultBilling,
        'created_at': _toTimestamp(createdAt),
        'updated_at': _toTimestamp(updatedAt),
      });
}

class FavoriteProduct {
  final String id; // productId ile aynı
  final String productId;
  final String? titleTr;
  final double? priceSnapshot;
  final String? thumbUrl;
  final DateTime? createdAt;

  const FavoriteProduct({
    required this.id,
    required this.productId,
    this.titleTr,
    this.priceSnapshot,
    this.thumbUrl,
    this.createdAt,
  });

  factory FavoriteProduct.fromMap(String id, Map<String, dynamic> map) => FavoriteProduct(
        id: id,
        productId: map['product_id'] as String? ?? id,
        titleTr: map['title_tr'] as String?,
        priceSnapshot: (map['price_snapshot'] as num?)?.toDouble(),
        thumbUrl: map['thumb_url'] as String?,
        createdAt: _toDateTime(map['created_at']),
      );

  Map<String, dynamic> toMap() => _nn({
        'product_id': productId,
        'title_tr': titleTr,
        'price_snapshot': priceSnapshot,
        'thumb_url': thumbUrl,
        'created_at': _toTimestamp(createdAt),
      });
}

class ConsentLog {
  final String id;
  final ConsentType consentType;
  final String? version;
  final DateTime? acceptedAt;
  final String? ip;
  final String? userAgent;

  const ConsentLog({
    required this.id,
    required this.consentType,
    this.version,
    this.acceptedAt,
    this.ip,
    this.userAgent,
  });

  factory ConsentLog.fromMap(String id, Map<String, dynamic> map) => ConsentLog(
        id: id,
        consentType: switch ((map['consent_type'] as String).toLowerCase()) {
          'kvkk' => ConsentType.kvkk,
          'marketing' => ConsentType.marketing,
          _ => ConsentType.tos,
        },
        version: map['version'] as String?,
        acceptedAt: _toDateTime(map['accepted_at']),
        ip: map['ip'] as String?,
        userAgent: map['user_agent'] as String?,
      );

  Map<String, dynamic> toMap() => _nn({
        'consent_type': switch (consentType) {
          ConsentType.kvkk => 'kvkk',
          ConsentType.marketing => 'marketing',
          ConsentType.tos => 'tos',
        },
        'version': version,
        'accepted_at': _toTimestamp(acceptedAt),
        'ip': ip,
        'user_agent': userAgent,
      });
}

class UserDevice {
  final String id;
  final String? fcmToken;
  final DevicePlatform? platform;
  final String? deviceModel;
  final String? appVersion;
  final bool? notificationsEnabled;
  final List<String>? locales;
  final DateTime? createdAt;
  final DateTime? lastSeenAt;

  const UserDevice({
    required this.id,
    this.fcmToken,
    this.platform,
    this.deviceModel,
    this.appVersion,
    this.notificationsEnabled,
    this.locales,
    this.createdAt,
    this.lastSeenAt,
  });

  factory UserDevice.fromMap(String id, Map<String, dynamic> map) => UserDevice(
        id: id,
        fcmToken: map['fcm_token'] as String?,
        platform: switch ((map['platform'] as String?)?.toLowerCase()) {
          'ios' => DevicePlatform.ios,
          'android' => DevicePlatform.android,
          'web' => DevicePlatform.web,
          _ => null,
        },
        deviceModel: map['device_model'] as String?,
        appVersion: map['app_version'] as String?,
        notificationsEnabled: map['notifications_enabled'] as bool?,
        locales: (map['locales'] as List?)?.whereType<String>().toList(),
        createdAt: _toDateTime(map['created_at']),
        lastSeenAt: _toDateTime(map['last_seen_at']),
      );

  Map<String, dynamic> toMap() => _nn({
        'fcm_token': fcmToken,
        'platform': switch (platform) {
          DevicePlatform.ios => 'ios',
          DevicePlatform.android => 'android',
          DevicePlatform.web => 'web',
          null => null,
        },
        'device_model': deviceModel,
        'app_version': appVersion,
        'notifications_enabled': notificationsEnabled,
        'locales': locales,
        'created_at': _toTimestamp(createdAt),
        'last_seen_at': _toTimestamp(lastSeenAt),
      });
}

// -------------------- Sepet (Cart) Modeli -------------------- //

class CartItem {
  final String id; // docId = productId
  final String productId;
  final int qty;
  final String? variantId; // varsa varyant/sku
  final Map<String, dynamic>? attrs; // {color: 'red', size: 'L'} gibi
  final double? priceSnapshot;
  final String? titleTr;
  final String? thumbUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const CartItem({
    required this.id,
    required this.productId,
    this.qty = 1,
    this.variantId,
    this.attrs,
    this.priceSnapshot,
    this.titleTr,
    this.thumbUrl,
    this.createdAt,
    this.updatedAt,
  });

  CartItem copyWith({
    String? id,
    String? productId,
    int? qty,
    String? variantId,
    Map<String, dynamic>? attrs,
    double? priceSnapshot,
    String? titleTr,
    String? thumbUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      CartItem(
        id: id ?? this.id,
        productId: productId ?? this.productId,
        qty: qty ?? this.qty,
        variantId: variantId ?? this.variantId,
        attrs: attrs ?? this.attrs,
        priceSnapshot: priceSnapshot ?? this.priceSnapshot,
        titleTr: titleTr ?? this.titleTr,
        thumbUrl: thumbUrl ?? this.thumbUrl,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory CartItem.fromMap(String id, Map<String, dynamic> map) => CartItem(
        id: id,
        productId: map['product_id'] as String? ?? id,
        qty: (map['qty'] as num?)?.toInt() ?? 1,
        variantId: map['variant_id'] as String?,
        attrs: (map['attrs'] as Map?)?.map((k, v) => MapEntry(k.toString(), v)),
        priceSnapshot: (map['price_snapshot'] as num?)?.toDouble(),
        titleTr: map['title_tr'] as String?,
        thumbUrl: map['thumb_url'] as String?,
        createdAt: _toDateTime(map['created_at']),
        updatedAt: _toDateTime(map['updated_at']),
      );

  Map<String, dynamic> toMap() => _nn({
        'product_id': productId,
        'qty': qty,
        'variant_id': variantId,
        'attrs': attrs ?? <String, dynamic>{},
        'price_snapshot': priceSnapshot,
        'title_tr': titleTr,
        'thumb_url': thumbUrl,
        'created_at': _toTimestamp(createdAt),
        'updated_at': _toTimestamp(updatedAt),
      });
}

// -------------------- Kök Kullanıcı Modeli -------------------- //

class AppUser {
  final String id; // uid
  final String email;
  final String? name;
  final String? avatarUrl;
  final UserRole role;
  final String preferredCurrency; // TRY, USD, ...
  final double? defaultDiscountRate; // 0.08 gibi
  final String? lang; // tr, en
  final bool isActive;

  final bool? emailVerified;
  final bool? phoneVerified;

  final bool? kvkkOk;
  final String? kvkkVersion;
  final DateTime? kvkkAcceptedAt;

  final String? defaultShippingAddressId;
  final String? defaultBillingAddressId;
  final String? defaultBillingProfileId;

  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? lastLoginAt;
  final DateTime? lastOrderAt;
  final DateTime? lastDeliveryAt;

  const AppUser({
    required this.id,
    required this.email,
    this.name,
    this.avatarUrl,
    this.role = UserRole.customer,
    this.preferredCurrency = 'TRY',
    this.defaultDiscountRate,
    this.lang,
    this.isActive = true,
    this.emailVerified,
    this.phoneVerified,
    this.kvkkOk,
    this.kvkkVersion,
    this.kvkkAcceptedAt,
    this.defaultShippingAddressId,
    this.defaultBillingAddressId,
    this.defaultBillingProfileId,
    this.createdAt,
    this.updatedAt,
    this.lastLoginAt,
    this.lastOrderAt,
    this.lastDeliveryAt,
  });

  factory AppUser.fromMap(String id, Map<String, dynamic> map) => AppUser(
        id: id,
        email: map['email'] as String? ?? '',
        name: map['name'] as String?,
        avatarUrl: (map['avatar_url'] as String?) ?? (map['avatar'] as String?),
        role: switch ((map['role'] as String?)?.toLowerCase()) {
          'admin' => UserRole.admin,
          'b2b' => UserRole.b2b,
          _ => UserRole.customer,
        },
        preferredCurrency: map['preferred_currency'] as String? ?? 'TRY',
        defaultDiscountRate: (map['default_discount_rate'] as num?)?.toDouble(),
        lang: map['lang'] as String?,
        isActive: (map['is_active'] ?? true) as bool,
        emailVerified: map['email_verified'] as bool?,
        phoneVerified: map['phone_verified'] as bool?,
        kvkkOk: map['kvkk_ok'] as bool?,
        kvkkVersion: map['kvkk_version'] as String?,
        kvkkAcceptedAt: _toDateTime(map['kvkk_accepted_at']),
        defaultShippingAddressId: map['default_shipping_address_id'] as String?,
        defaultBillingAddressId: map['default_billing_address_id'] as String?,
        defaultBillingProfileId: map['default_billing_profile_id'] as String?,
        createdAt: _toDateTime(map['created_at']),
        updatedAt: _toDateTime(map['updated_at']),
        lastLoginAt: _toDateTime(map['last_login_at']),
        lastOrderAt: _toDateTime(map['last_order_at']),
        lastDeliveryAt: _toDateTime(map['last_delivery_at']),
      );

  Map<String, dynamic> toMap() => _nn({
        'email': email,
        'name': name,
        'avatar_url': avatarUrl,
        'role': switch (role) {
          UserRole.admin => 'admin',
          UserRole.b2b => 'b2b',
          UserRole.customer => 'customer',
        },
        'preferred_currency': preferredCurrency,
        'default_discount_rate': defaultDiscountRate,
        'lang': lang,
        'is_active': isActive,
        'email_verified': emailVerified,
        'phone_verified': phoneVerified,
        'kvkk_ok': kvkkOk,
        'kvkk_version': kvkkVersion,
        'kvkk_accepted_at': _toTimestamp(kvkkAcceptedAt),
        'default_shipping_address_id': defaultShippingAddressId,
        'default_billing_address_id': defaultBillingAddressId,
        'default_billing_profile_id': defaultBillingProfileId,
        'created_at': _toTimestamp(createdAt),
        'updated_at': _toTimestamp(updatedAt),
        'last_login_at': _toTimestamp(lastLoginAt),
        'last_order_at': _toTimestamp(lastOrderAt),
        'last_delivery_at': _toTimestamp(lastDeliveryAt),
      });

  AppUser copyWith({
    String? id,
    String? email,
    String? name,
    String? avatarUrl,
    UserRole? role,
    String? preferredCurrency,
    double? defaultDiscountRate,
    String? lang,
    bool? isActive,
    bool? emailVerified,
    bool? phoneVerified,
    bool? kvkkOk,
    String? kvkkVersion,
    DateTime? kvkkAcceptedAt,
    String? defaultShippingAddressId,
    String? defaultBillingAddressId,
    String? defaultBillingProfileId,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastLoginAt,
    DateTime? lastOrderAt,
    DateTime? lastDeliveryAt,
  }) =>
      AppUser(
        id: id ?? this.id,
        email: email ?? this.email,
        name: name ?? this.name,
        avatarUrl: avatarUrl ?? this.avatarUrl,
        role: role ?? this.role,
        preferredCurrency: preferredCurrency ?? this.preferredCurrency,
        defaultDiscountRate: defaultDiscountRate ?? this.defaultDiscountRate,
        lang: lang ?? this.lang,
        isActive: isActive ?? this.isActive,
        emailVerified: emailVerified ?? this.emailVerified,
        phoneVerified: phoneVerified ?? this.phoneVerified,
        kvkkOk: kvkkOk ?? this.kvkkOk,
        kvkkVersion: kvkkVersion ?? this.kvkkVersion,
        kvkkAcceptedAt: kvkkAcceptedAt ?? this.kvkkAcceptedAt,
        defaultShippingAddressId: defaultShippingAddressId ?? this.defaultShippingAddressId,
        defaultBillingAddressId: defaultBillingAddressId ?? this.defaultBillingAddressId,
        defaultBillingProfileId: defaultBillingProfileId ?? this.defaultBillingProfileId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        lastLoginAt: lastLoginAt ?? this.lastLoginAt,
        lastOrderAt: lastOrderAt ?? this.lastOrderAt,
        lastDeliveryAt: lastDeliveryAt ?? this.lastDeliveryAt,
      );

  factory AppUser.empty(String uid, String email) => AppUser(
        id: uid,
        email: email,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        isActive: true,
        preferredCurrency: 'TRY',
        role: UserRole.customer,
      );
}

// -------------------- Firestore Helpers -------------------- //

class UserRefs {
  final FirebaseFirestore _db;
  const UserRefs(this._db);

  // Collections (typed)
  CollectionReference<AppUser> users() => _db.collection('users').withConverter<AppUser>(fromFirestore: (snap, _) => AppUser.fromMap(snap.id, snap.data() ?? {}), toFirestore: (u, _) => u.toMap());

  DocumentReference<AppUser> userDoc(String uid) => users().doc(uid);

  CollectionReference<UserAddress> addresses(String uid) => _db.collection('users').doc(uid).collection('addresses').withConverter<UserAddress>(fromFirestore: (s, _) => UserAddress.fromMap(s.id, s.data() ?? {}), toFirestore: (a, _) => a.toMap());

  CollectionReference<BillingProfile> billingProfiles(String uid) => _db.collection('users').doc(uid).collection('billing_profiles').withConverter<BillingProfile>(fromFirestore: (s, _) => BillingProfile.fromMap(s.id, s.data() ?? {}), toFirestore: (b, _) => b.toMap());

  CollectionReference<FavoriteProduct> favorites(String uid) => _db.collection('users').doc(uid).collection('favorites').withConverter<FavoriteProduct>(fromFirestore: (s, _) => FavoriteProduct.fromMap(s.id, s.data() ?? {}), toFirestore: (f, _) => f.toMap());

  CollectionReference<ConsentLog> consents(String uid) => _db.collection('users').doc(uid).collection('consents').withConverter<ConsentLog>(fromFirestore: (s, _) => ConsentLog.fromMap(s.id, s.data() ?? {}), toFirestore: (c, _) => c.toMap());

  CollectionReference<UserDevice> devices(String uid) => _db.collection('users').doc(uid).collection('devices').withConverter<UserDevice>(fromFirestore: (s, _) => UserDevice.fromMap(s.id, s.data() ?? {}), toFirestore: (d, _) => d.toMap());

  CollectionReference<CartItem> cart(String uid) => _db.collection('users').doc(uid).collection('cart').withConverter<CartItem>(fromFirestore: (s, _) => CartItem.fromMap(s.id, s.data() ?? {}), toFirestore: (c, _) => c.toMap());

  // -------------------- ServerTimestamp ile yazımlar -------------------- //

  Future<void> createUserWithDefaults(
    AppUser u, {
    required UserAddress defaultAddress,
    required BillingProfile defaultBilling,
  }) async {
    final userRef = _db.collection('users').doc(u.id);
    final addrRef = userRef.collection('addresses').doc('addr_ship');
    final billRef = userRef.collection('billing_profiles').doc('bill_company');

    await _db.runTransaction((tx) async {
      tx.set(
          userRef,
          {
            ...u.toMap(),
            'created_at': FieldValue.serverTimestamp(),
            'updated_at': FieldValue.serverTimestamp(),
            'default_shipping_address_id': addrRef.id,
            'default_billing_address_id': addrRef.id,
            'default_billing_profile_id': billRef.id,
          },
          SetOptions(merge: true));

      tx.set(addrRef, {
        ...defaultAddress.toMap(),
        'is_default_shipping': true,
        'is_default_billing': true,
        'created_at': FieldValue.serverTimestamp(),
        'updated_at': FieldValue.serverTimestamp(),
      });

      tx.set(billRef, {
        ...defaultBilling.toMap(),
        'is_default_billing': true,
        'created_at': FieldValue.serverTimestamp(),
        'updated_at': FieldValue.serverTimestamp(),
      });
    });
  }

  // -------------------- Sepet işlemleri -------------------- //

  Stream<List<CartItem>> watchCart(String uid) => cart(uid).orderBy('created_at', descending: true).snapshots().map((qs) => qs.docs.map((d) => d.data()).toList());

  Future<void> addOrIncrementCartItem(String uid, CartItem item, {int incrementQty = 1}) async {
    final rawRef = _db.collection('users').doc(uid).collection('cart').doc(item.productId);
    await _db.runTransaction((tx) async {
      final snap = await tx.get(rawRef);
      if (snap.exists) {
        final data = snap.data() as Map<String, dynamic>;
        final current = (data['qty'] as num?)?.toInt() ?? 0;
        tx.update(rawRef, {
          'qty': current + (incrementQty <= 0 ? 1 : incrementQty),
          'updated_at': FieldValue.serverTimestamp(),
        });
      } else {
        tx.set(rawRef, {
          ...item.toMap(),
          'product_id': item.productId,
          'qty': item.qty <= 0 ? 1 : item.qty,
          'created_at': FieldValue.serverTimestamp(),
          'updated_at': FieldValue.serverTimestamp(),
        });
      }
    });
  }

  Future<void> updateCartQty(String uid, String productId, int qty) async {
    final ref = _db.collection('users').doc(uid).collection('cart').doc(productId);
    if (qty <= 0) {
      await ref.delete();
    } else {
      await ref.set({
        'qty': qty,
        'updated_at': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    }
  }

  Future<void> removeCartItem(String uid, String productId) async {
    await _db.collection('users').doc(uid).collection('cart').doc(productId).delete();
  }

  Future<void> clearCart(String uid) async {
    final qs = await _db.collection('users').doc(uid).collection('cart').get();
    final batch = _db.batch();
    for (final d in qs.docs) {
      batch.delete(d.reference);
    }
    await batch.commit();
  }

  // -------------------- Varsayılan adres/profil -------------------- //

  Future<void> setDefaultAddress(String uid, String addressId, {bool shipping = true, bool billing = false}) async {
    final userRef = _db.collection('users').doc(uid);
    final col = userRef.collection('addresses');
    final qs = await col.get();
    final batch = _db.batch();

    if (shipping) {
      for (final d in qs.docs) {
        batch.update(d.reference, {
          'is_default_shipping': d.id == addressId,
          'updated_at': FieldValue.serverTimestamp(),
        });
      }
      batch.update(userRef, {
        'default_shipping_address_id': addressId,
        'updated_at': FieldValue.serverTimestamp(),
      });
    }

    if (billing) {
      for (final d in qs.docs) {
        batch.update(d.reference, {
          'is_default_billing': d.id == addressId,
          'updated_at': FieldValue.serverTimestamp(),
        });
      }
      batch.update(userRef, {
        'default_billing_address_id': addressId,
        'updated_at': FieldValue.serverTimestamp(),
      });
    }

    await batch.commit();
  }

  Future<void> setDefaultBillingProfile(String uid, String profileId) async {
    final userRef = _db.collection('users').doc(uid);
    final col = userRef.collection('billing_profiles');
    final qs = await col.get();
    final batch = _db.batch();

    for (final d in qs.docs) {
      batch.update(d.reference, {
        'is_default_billing': d.id == profileId,
        'updated_at': FieldValue.serverTimestamp(),
      });
    }
    batch.update(userRef, {
      'default_billing_profile_id': profileId,
      'updated_at': FieldValue.serverTimestamp(),
    });

    await batch.commit();
  }
}

// -------------------- Örnek varsayılan dokümanlar -------------------- //

UserAddress defaultShippingAddressTemplate(
  String id, {
  String title = 'Ev',
  String country = 'TR',
  String city = 'İstanbul',
  String district = 'Kağıthane',
  String neighborhood = 'Seyrantepe',
  String postalCode = '34410',
  String addressLine = 'Cendere Cd. No:12 D:5',
  String contactName = 'Ad Soyad',
  String phoneE164 = '+905550000000',
}) =>
    UserAddress(
      id: id,
      title: title,
      country: country,
      city: city,
      district: district,
      neighborhood: neighborhood,
      postalCode: postalCode,
      addressLine: addressLine,
      contactName: contactName,
      phoneE164: phoneE164,
      isDefaultShipping: true,
      isDefaultBilling: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

BillingProfile defaultCompanyBillingProfile(String id) => BillingProfile(
      id: id,
      type: BillingType.efatura,
      companyTitle: 'Ewros Mobilya A.Ş.',
      vkn: '1234567890',
      taxOffice: 'Maslak',
      mersisNo: '0123456789012345',
      eInvoiceAlias: 'urn:mail:ewros@einvoice.gov.tr',
      eArchive: true,
      country: 'TR',
      city: 'İstanbul',
      district: 'Kağıthane',
      postalCode: '34410',
      addressLine: 'Cendere Cd. No:12',
      isDefaultBilling: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
