pub const packages = struct {
    pub const @"1220232ab38d0c2cfb10680115c17ad2fa1a8531dbaf8bbfb359ec67e80c7d5f5758" = struct {
        pub const build_root = "C:\\Users\\Ben\\AppData\\Local\\zig\\p\\1220232ab38d0c2cfb10680115c17ad2fa1a8531dbaf8bbfb359ec67e80c7d5f5758";
        pub const build_zig = @import("1220232ab38d0c2cfb10680115c17ad2fa1a8531dbaf8bbfb359ec67e80c7d5f5758");
        pub const deps: []const struct { []const u8, []const u8 } = &.{};
    };
    pub const @"12206d8d2a7f2535a7d48872eaf43911ead71ba05456f97363ae25e4f057a985975f" = struct {
        pub const build_root = "C:\\Users\\Ben\\AppData\\Local\\zig\\p\\12206d8d2a7f2535a7d48872eaf43911ead71ba05456f97363ae25e4f057a985975f";
        pub const build_zig = @import("12206d8d2a7f2535a7d48872eaf43911ead71ba05456f97363ae25e4f057a985975f");
        pub const deps: []const struct { []const u8, []const u8 } = &.{
            .{ "metrics", "1220232ab38d0c2cfb10680115c17ad2fa1a8531dbaf8bbfb359ec67e80c7d5f5758" },
            .{ "websocket", "12208720b772330f309cfb48957f4152ee0930b716837d0c1d07fee2dea2f4dc712e" },
        };
    };
    pub const @"12208720b772330f309cfb48957f4152ee0930b716837d0c1d07fee2dea2f4dc712e" = struct {
        pub const build_root = "C:\\Users\\Ben\\AppData\\Local\\zig\\p\\12208720b772330f309cfb48957f4152ee0930b716837d0c1d07fee2dea2f4dc712e";
        pub const build_zig = @import("12208720b772330f309cfb48957f4152ee0930b716837d0c1d07fee2dea2f4dc712e");
        pub const deps: []const struct { []const u8, []const u8 } = &.{
        };
    };
};

pub const root_deps: []const struct { []const u8, []const u8 } = &.{
    .{ "httpz", "12206d8d2a7f2535a7d48872eaf43911ead71ba05456f97363ae25e4f057a985975f" },
};
