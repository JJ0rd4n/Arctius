workspace "Arctius"
	architecture "x64"

	configurations
	{
		"Debug",
		"Release",
		"Dist"
	}

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

startproject "Sandbox"

IncludeDir = {}
IncludeDir["GLFW"] = "Arctius/vendor/GLFW/include"

include "Arctius/vendor/GLFW"

project "Arctius"
	location "Arctius"
	kind "SharedLib"
	language "C++"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")
	
	pchheader "arcpch.h"
	pchsource "Arctius/src/arcpch.cpp"

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp"
	}

	includedirs
	{
		"%{prj.name}/src",
		"%{prj.name}/vendor/spdlog/include",
		"%{IncludeDir.GLFW}"
	}

	links 
	{ 
		"GLFW",
		"opengl32.lib"
	}

	filter "system:windows"
		cppdialect "C++17"
		staticruntime "On"
		systemversion "latest"

		defines
		{
			"ARC_PLATFORM_WINDOWS",
			"ARC_BUILD_DLL"
		}

		postbuildcommands
		{
			("{COPY} %{cfg.buildtarget.relpath} ../bin/" .. outputdir .. "/Sandbox")
		}
	
	filter "configurations:Debug"
		defines "ARC_DEBUG"
		symbols "On"

	filter "configurations:Release"
		defines "ARC_RELEASE"
		symbols "On"

	filter "configurations:Dist"
		defines "ARC_DIST"
		symbols "On"

project "Sandbox"
	location "Sandbox"
	kind "ConsoleApp"
	language "C++"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp"
	}

	includedirs
	{
		"Arctius/vendor/spdlog/include",
		"Arctius/src"
	}

	links
	{
		"Arctius"
	}

	filter "system:windows"
		cppdialect "C++17"
		staticruntime "On"
		systemversion "latest"

		defines
		{
			"ARC_PLATFORM_WINDOWS"
		}
	
	filter "configurations:Debug"
		defines "ARC_DEBUG"
		symbols "On"

	filter "configurations:Release"
		defines "ARC_RELEASE"
		symbols "On"

	filter "configurations:Dist"
		defines "ARC_DIST"
		symbols "On"