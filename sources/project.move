module MyModule::NFTProfileBadges {

    use std::string;
    use aptos_framework::signer;

    struct ProfileBadge has store, key {
        name: string::String,
        icon: string::String,
    }

    public fun mint_badge(user: &signer, name: string::String, icon: string::String) {
        assert!(!exists<ProfileBadge>(signer::address_of(user)), 1);
        let badge = ProfileBadge { name, icon };
        move_to(user, badge);
    }

    /// Returns references instead of cloning
    public fun get_badge(owner: address): (&string::String, &string::String) acquires ProfileBadge {
        let badge = borrow_global<ProfileBadge>(owner);
        (&badge.name, &badge.icon)
    }
}
