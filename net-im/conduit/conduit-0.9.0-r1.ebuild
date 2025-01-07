# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	addr2line@0.22.0
	adler@1.0.2
	ahash@0.8.11
	aho-corasick@1.1.3
	anstyle@1.0.7
	anyhow@1.0.86
	arc-swap@1.7.1
	arrayref@0.3.7
	arrayvec@0.7.4
	as_variant@1.2.0
	assign@1.1.1
	async-stream-impl@0.3.5
	async-stream@0.3.5
	async-trait@0.1.80
	atomic-waker@1.1.2
	atomic@0.6.0
	autocfg@1.3.0
	axum-core@0.3.4
	axum-core@0.4.3
	axum-extra@0.9.3
	axum-server@0.6.0
	axum@0.6.20
	axum@0.7.5
	backtrace@0.3.72
	base64@0.21.7
	base64@0.22.1
	base64ct@1.6.0
	bindgen@0.69.4
	bitflags@1.3.2
	bitflags@2.5.0
	blake2b_simd@1.0.2
	block-buffer@0.10.4
	bumpalo@3.16.0
	bytemuck@1.16.0
	byteorder@1.5.0
	bytes@1.6.0
	bzip2-sys@0.1.11+1.0.8
	cc@1.0.98
	cexpr@0.6.0
	cfg-if@1.0.0
	cfg_aliases@0.1.1
	clang-sys@1.8.1
	clap@4.5.4
	clap_builder@4.5.2
	clap_derive@4.5.4
	clap_lex@0.7.0
	color_quant@1.1.0
	const-oid@0.9.6
	const_panic@0.2.8
	constant_time_eq@0.3.0
	core-foundation-sys@0.8.6
	core-foundation@0.9.4
	cpufeatures@0.2.12
	crc-catalog@2.4.0
	crc32fast@1.4.2
	crc@3.2.1
	crossbeam-channel@0.5.13
	crossbeam-utils@0.8.20
	crypto-common@0.1.6
	curve25519-dalek-derive@0.1.1
	curve25519-dalek@4.1.2
	data-encoding@2.6.0
	date_header@1.0.5
	der@0.7.9
	deranged@0.3.11
	digest@0.10.7
	directories@5.0.1
	dirs-sys@0.4.1
	ed25519-dalek@2.1.1
	ed25519@2.2.3
	either@1.12.0
	enum-as-inner@0.6.0
	equivalent@1.0.1
	fallible-iterator@0.3.0
	fallible-streaming-iterator@0.1.9
	fdeflate@0.3.4
	fiat-crypto@0.2.9
	figment@0.10.19
	flate2@1.0.30
	fnv@1.0.7
	form_urlencoded@1.2.1
	fs2@0.4.3
	futures-channel@0.3.30
	futures-core@0.3.30
	futures-executor@0.3.30
	futures-io@0.3.30
	futures-macro@0.3.30
	futures-sink@0.3.30
	futures-task@0.3.30
	futures-util@0.3.30
	generic-array@0.14.7
	getrandom@0.2.15
	gif@0.13.1
	gimli@0.29.0
	glob@0.3.1
	h2@0.3.26
	h2@0.4.5
	hashbrown@0.12.3
	hashbrown@0.14.5
	hashlink@0.9.1
	headers-core@0.3.0
	headers@0.4.0
	heck@0.4.1
	heck@0.5.0
	hermit-abi@0.3.9
	hickory-proto@0.24.1
	hickory-resolver@0.24.1
	hmac@0.12.1
	hostname@0.3.1
	http-auth@0.1.9
	http-body-util@0.1.1
	http-body@0.4.6
	http-body@1.0.0
	http@0.2.12
	http@1.1.0
	httparse@1.9.4
	httpdate@1.0.3
	hyper-rustls@0.26.0
	hyper-timeout@0.4.1
	hyper-util@0.1.5
	hyper@0.14.29
	hyper@1.3.1
	idna@0.4.0
	idna@0.5.0
	image@0.25.1
	indexmap@1.9.3
	indexmap@2.2.6
	inlinable_string@0.1.15
	ipconfig@0.3.2
	ipnet@2.9.0
	itertools@0.12.1
	itoa@1.0.11
	jobserver@0.1.31
	js-sys@0.3.69
	js_int@0.2.2
	js_option@0.1.1
	jsonwebtoken@9.3.0
	konst@0.3.9
	konst_kernel@0.3.9
	lazy_static@1.4.0
	lazycell@1.3.0
	libc@0.2.155
	libloading@0.8.3
	libredox@0.1.3
	libsqlite3-sys@0.28.0
	libz-sys@1.1.18
	linked-hash-map@0.5.6
	lock_api@0.4.12
	log@0.4.21
	lru-cache@0.1.2
	lz4-sys@1.9.4
	maplit@1.0.2
	match_cfg@0.1.0
	matchers@0.1.0
	matchit@0.7.3
	memchr@2.7.2
	mime@0.3.17
	minimal-lexical@0.2.1
	miniz_oxide@0.7.3
	mio@0.8.11
	nix@0.28.0
	nom@7.1.3
	nu-ansi-term@0.46.0
	num-bigint@0.4.5
	num-conv@0.1.0
	num-integer@0.1.46
	num-traits@0.2.19
	num_cpus@1.16.0
	object@0.35.0
	once_cell@1.19.0
	openssl-probe@0.1.5
	opentelemetry-jaeger-propagator@0.1.0
	opentelemetry-otlp@0.15.0
	opentelemetry-proto@0.5.0
	opentelemetry-semantic-conventions@0.14.0
	opentelemetry@0.22.0
	opentelemetry_sdk@0.22.1
	option-ext@0.2.0
	ordered-float@4.2.0
	overload@0.1.1
	parking_lot@0.12.3
	parking_lot_core@0.9.10
	pear@0.2.9
	pear_codegen@0.2.9
	pem@3.0.4
	percent-encoding@2.3.1
	persy@1.5.0
	pin-project-internal@1.1.5
	pin-project-lite@0.2.14
	pin-project@1.1.5
	pin-utils@0.1.0
	pkcs8@0.10.2
	pkg-config@0.3.30
	platforms@3.4.0
	png@0.17.13
	powerfmt@0.2.0
	ppv-lite86@0.2.17
	proc-macro-crate@3.1.0
	proc-macro2-diagnostics@0.10.1
	proc-macro2@1.0.85
	prost-derive@0.12.6
	prost@0.12.6
	quick-error@1.2.3
	quote@1.0.36
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.4
	redox_syscall@0.5.1
	redox_users@0.4.5
	regex-automata@0.1.10
	regex-automata@0.4.6
	regex-syntax@0.6.29
	regex-syntax@0.8.3
	regex@1.10.4
	reqwest@0.12.4
	resolv-conf@0.7.0
	ring@0.17.8
	rusqlite@0.31.0
	rust-argon2@2.1.0
	rust-librocksdb-sys@0.21.0+9.1.1
	rust-rocksdb@0.25.0
	rustc-demangle@0.1.24
	rustc-hash@1.1.0
	rustc_version@0.4.0
	rustls-native-certs@0.7.0
	rustls-pemfile@2.1.2
	rustls-pki-types@1.7.0
	rustls-webpki@0.101.7
	rustls-webpki@0.102.4
	rustls@0.21.12
	rustls@0.22.4
	rustversion@1.0.17
	ryu@1.0.18
	schannel@0.1.23
	scopeguard@1.2.0
	sct@0.7.1
	sd-notify@0.4.1
	security-framework-sys@2.11.0
	security-framework@2.11.0
	semver@1.0.23
	serde@1.0.203
	serde_derive@1.0.203
	serde_html_form@0.2.6
	serde_json@1.0.117
	serde_path_to_error@0.1.16
	serde_spanned@0.6.6
	serde_urlencoded@0.7.1
	serde_yaml@0.9.34+deprecated
	sha-1@0.10.1
	sha1@0.10.6
	sha2@0.10.8
	sharded-slab@0.1.7
	shlex@1.3.0
	signal-hook-registry@1.4.2
	signature@2.2.0
	simd-adler32@0.3.7
	simple_asn1@0.6.2
	slab@0.4.9
	smallvec@1.13.2
	socket2@0.5.7
	spin@0.9.8
	spki@0.7.3
	subslice@0.2.3
	subtle@2.5.0
	syn@2.0.66
	sync_wrapper@0.1.2
	sync_wrapper@1.0.1
	thiserror-impl@1.0.61
	thiserror@1.0.61
	thread_local@1.1.8
	threadpool@1.8.1
	tikv-jemalloc-sys@0.5.4+5.3.0-patched
	tikv-jemallocator@0.5.4
	time-core@0.1.2
	time-macros@0.2.18
	time@0.3.36
	tinyvec@1.6.0
	tinyvec_macros@0.1.1
	tokio-io-timeout@1.2.0
	tokio-macros@2.3.0
	tokio-rustls@0.24.1
	tokio-rustls@0.25.0
	tokio-socks@0.5.1
	tokio-stream@0.1.15
	tokio-util@0.7.11
	tokio@1.38.0
	toml@0.8.14
	toml_datetime@0.6.6
	toml_edit@0.21.1
	toml_edit@0.22.14
	tonic@0.11.0
	tower-http@0.5.2
	tower-layer@0.3.2
	tower-service@0.3.2
	tower@0.4.13
	tracing-attributes@0.1.27
	tracing-core@0.1.32
	tracing-flame@0.2.0
	tracing-log@0.2.0
	tracing-opentelemetry@0.23.0
	tracing-subscriber@0.3.18
	tracing@0.1.40
	try-lock@0.2.5
	typenum@1.17.0
	typewit@1.9.0
	typewit_proc_macros@1.8.1
	uncased@0.9.10
	unicode-bidi@0.3.15
	unicode-ident@1.0.12
	unicode-normalization@0.1.23
	unsafe-libyaml@0.2.11
	unsigned-varint@0.8.0
	untrusted@0.9.0
	url@2.5.0
	urlencoding@2.1.3
	uuid@1.8.0
	valuable@0.1.0
	vcpkg@0.2.15
	version_check@0.9.4
	want@0.3.1
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen-backend@0.2.92
	wasm-bindgen-futures@0.4.42
	wasm-bindgen-macro-support@0.2.92
	wasm-bindgen-macro@0.2.92
	wasm-bindgen-shared@0.2.92
	wasm-bindgen@0.2.92
	web-sys@0.3.69
	web-time@1.1.0
	weezl@0.1.8
	widestring@1.1.0
	wildmatch@2.3.4
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-sys@0.48.0
	windows-sys@0.52.0
	windows-targets@0.48.5
	windows-targets@0.52.5
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_gnullvm@0.52.5
	windows_aarch64_msvc@0.48.5
	windows_aarch64_msvc@0.52.5
	windows_i686_gnu@0.48.5
	windows_i686_gnu@0.52.5
	windows_i686_gnullvm@0.52.5
	windows_i686_msvc@0.48.5
	windows_i686_msvc@0.52.5
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnu@0.52.5
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_gnullvm@0.52.5
	windows_x86_64_msvc@0.48.5
	windows_x86_64_msvc@0.52.5
	winnow@0.5.40
	winnow@0.6.11
	winreg@0.50.0
	winreg@0.52.0
	yansi@1.0.1
	zerocopy-derive@0.7.34
	zerocopy@0.7.34
	zeroize@1.8.1
	zigzag@0.1.0
	zstd-sys@2.0.10+zstd.1.5.6
	zune-core@0.4.12
	zune-jpeg@0.4.11
"
LLVM_COMPAT=( {15..19} )
RUST_MIN_VER="1.79.0"

declare -A GIT_CRATES=(
	[ruma-appservice-api]='https://github.com/ruma/ruma;c06af4385e0e30c48a8e9ca3d488da32102d0db9;ruma-%commit%/crates/ruma-appservice-api'
	[ruma-client-api]='https://github.com/ruma/ruma;c06af4385e0e30c48a8e9ca3d488da32102d0db9;ruma-%commit%/crates/ruma-client-api'
	[ruma-common]='https://github.com/ruma/ruma;c06af4385e0e30c48a8e9ca3d488da32102d0db9;ruma-%commit%/crates/ruma-common'
	[ruma-events]='https://github.com/ruma/ruma;c06af4385e0e30c48a8e9ca3d488da32102d0db9;ruma-%commit%/crates/ruma-events'
	[ruma-federation-api]='https://github.com/ruma/ruma;c06af4385e0e30c48a8e9ca3d488da32102d0db9;ruma-%commit%/crates/ruma-federation-api'
	[ruma-identifiers-validation]='https://github.com/ruma/ruma;c06af4385e0e30c48a8e9ca3d488da32102d0db9;ruma-%commit%/crates/ruma-identifiers-validation'
	[ruma-identity-service-api]='https://github.com/ruma/ruma;c06af4385e0e30c48a8e9ca3d488da32102d0db9;ruma-%commit%/crates/ruma-identity-service-api'
	[ruma-macros]='https://github.com/ruma/ruma;c06af4385e0e30c48a8e9ca3d488da32102d0db9;ruma-%commit%/crates/ruma-macros'
	[ruma-push-gateway-api]='https://github.com/ruma/ruma;c06af4385e0e30c48a8e9ca3d488da32102d0db9;ruma-%commit%/crates/ruma-push-gateway-api'
	[ruma-server-util]='https://github.com/ruma/ruma;c06af4385e0e30c48a8e9ca3d488da32102d0db9;ruma-%commit%/crates/ruma-server-util'
	[ruma-signatures]='https://github.com/ruma/ruma;c06af4385e0e30c48a8e9ca3d488da32102d0db9;ruma-%commit%/crates/ruma-signatures'
	[ruma-state-res]='https://github.com/ruma/ruma;c06af4385e0e30c48a8e9ca3d488da32102d0db9;ruma-%commit%/crates/ruma-state-res'
	[ruma]='https://github.com/ruma/ruma;c06af4385e0e30c48a8e9ca3d488da32102d0db9;ruma-%commit%/crates/ruma'
)

inherit cargo llvm-r2 systemd toolchain-funcs

MY_P="${PN}-v${PV}"
DESCRIPTION="Matrix homeserver written in Rust"
HOMEPAGE="
	https://conduit.rs
	https://gitlab.com/famedly/conduit
"
SRC_URI="https://gitlab.com/famedly/${PN}/-/archive/v${PV}/${MY_P}.tar.bz2
	${CARGO_CRATE_URIS}
"
S="${WORKDIR}/${MY_P}"

LICENSE="Apache-2.0"
# Dependent crate licenses
LICENSE+="
	|| ( 0BSD Apache-2.0 MIT )
	|| ( Apache-2.0 Apache-2.0-with-LLVM-exceptions MIT )
	|| ( Apache-2.0 BSD MIT )
	|| ( Apache-2.0 BSD-1 MIT )
	|| ( Apache-2.0 BSD-2 MIT )
	|| ( Apache-2.0 Boost-1.0 )
	|| ( Apache-2.0 CC0-1.0 MIT )
	|| ( Apache-2.0 ISC MIT )
	|| ( Apache-2.0 MIT )
	|| ( Apache-2.0 MIT ZLIB )
	|| ( MIT Unlicense )
	BSD BSD-2 ISC MIT MPL-2.0 Unicode-DFS-2016 ZLIB openssl
"
SLOT="0"
KEYWORDS="~amd64"
IUSE="jemalloc rocksdb system-rocksdb"

# Libraries that can't be unbundled right now:
#	- app-arch/bzip2 (no pkg-config file)
#	- app-arch/lz4 ("lz4-sys" crate doesn't look for system library... ironic)
#	- dev-db/sqlite:3 ("conduit" pulls "rusqlite[bundled]" explicitly)
#	- sys-libs/zlib ("rust-librocksdb-sys" pulls "libz-sys[static]" by default)
COMMON_DEPEND="
	jemalloc? ( dev-libs/jemalloc:= )
	rocksdb? (
		app-arch/snappy:=
		app-arch/zstd:=
		system-rocksdb? ( dev-libs/rocksdb )
	)
"
RDEPEND="${COMMON_DEPEND}
	acct-user/conduit
	app-misc/ca-certificates
"
# clang needed for bindgen
DEPEND="${COMMON_DEPEND}
	rocksdb? (
		$(llvm_gen_dep '
			llvm-core/clang:${LLVM_SLOT}
			llvm-core/llvm:${LLVM_SLOT}
		')
	)
"
BDEPEND="
	rocksdb? (
		virtual/pkgconfig
	)
"

DOCS=( {APPSERVICES,CODE_OF_CONDUCT,DEPLOY,README,TURN}.md )

QA_FLAGS_IGNORED="usr/bin/${PN}"

pkg_setup() {
	use rocksdb && llvm-r2_pkg_setup
	rust_pkg_setup
}

src_configure() {
	# Tracker bug for that Cargo nonsense:
	# https://bugs.gentoo.org/709568
	export PKG_CONFIG_ALLOW_CROSS=1
	export ZSTD_SYS_USE_PKG_CONFIG=1
	export SNAPPY_LIB_DIR="${ESYSROOT}/usr/$(get_libdir)"
	export JEMALLOC_OVERRIDE="${ESYSROOT}/usr/$(get_libdir)/libjemalloc.so"

	if use system-rocksdb; then
		export ROCKSDB_INCLUDE_DIR="${ESYSROOT}/usr/include"
		export ROCKSDB_LIB_DIR="${ESYSROOT}/usr/$(get_libdir)"
	elif use rocksdb; then
		# Rust uses 'gcc' or 'clang' (not 'g++' or 'clang++'), so C++ standard
		# library needs to be linked explicitly.
		if [[ $(tc-get-cxx-stdlib) == "libstdc++" ]]; then
			append-ldflags -lstdc++
		elif [[ $(tc-get-cxx-stdlib) == "libc++" ]]; then
			append-ldflags -lc++
		fi
	fi

	local myfeatures=(
		conduit_bin
		systemd
		$(usev jemalloc)

		# database backends
		backend_persy
		backend_sqlite
		$(usex rocksdb backend_rocksdb '')
	)

	cargo_src_configure --no-default-features
}

src_install() {
	cargo_src_install

	keepdir /var/lib/matrix-conduit
	fowners conduit:conduit /var/lib/matrix-conduit
	fperms 700 /var/lib/matrix-conduit

	insinto /etc/conduit
	newins conduit-example.toml conduit.toml

	insinto /etc/logrotate.d
	newins "${FILESDIR}"/conduit.logrotate conduit

	newinitd "${FILESDIR}"/conduit.initd conduit
	newconfd "${FILESDIR}"/conduit.confd conduit
	systemd_dounit "${FILESDIR}"/conduit.service
}
