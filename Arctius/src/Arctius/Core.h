#pragma once

#ifdef ARC_PLATFORM_WINDOWS
	#ifdef ARC_BUILD_DLL
		#define ARCTIUS_API __declspec(dllexport)
	#else
		#define ARCTIUS_API __declspec(dllimport)
	#endif
#else
	#error Arctius only supports Windows...
#endif

#ifdef ARC_ENABLE_ASSERTS
	#define ARC_ASSERT(x, ...) { if(!(x)) { ARC_ERROR("Assertion Failed: {0}", __VA_ARGS__); __debugbreak(); } }
	#define ARC_CORE_ASSERT(x, ...) { if(!(x)) { ARC_CORE_ERROR("Assertion Failed: {0}", __VA_ARGS__); __debugbreak(); } }
#else
#define ARC_ASSERT(x, ...)
#define ARC_CORE_ASSERT(x, ...)
#endif

#define BIT(x) (1 << x)