#include <iostream>
#include <string>
#include <algorithm>
#include <fstream>
#include <filesystem>
#include <vector>
#include <array>
#include <cstdlib>

#ifdef _WIN32
    #include <winsock2.h>
    #include <ws2tcpip.h>
    #pragma comment(lib, "ws2_32.lib")
    using SocketType = SOCKET;
    #define INVALID_SOCKET_VALUE INVALID_SOCKET
#else
    #include <sys/socket.h>
    #include <arpa/inet.h>
    #include <unistd.h>
    #include <fcntl.h>
    #include <errno.h>
    using SocketType = int;
    #define INVALID_SOCKET_VALUE (-1)
#endif

bool isUrlAvailable(const std::string& ip, int port, int timeout_ms = 2000) 
{
    std::string clean_ip = ip.substr(7);
    size_t colon = clean_ip.find(':');
    if (colon != std::string::npos) {
        clean_ip = clean_ip.substr(0, colon);
    }

    #ifdef _WIN32
        WSADATA wsa;
        if (WSAStartup(MAKEWORD(2,2), &wsa) != 0) return false;
    #endif

    SocketType sock = socket(AF_INET, SOCK_STREAM, 0);
    if (sock == INVALID_SOCKET_VALUE) {
    #ifdef _WIN32
        WSACleanup();
    #endif
        return false;
    }

    struct timeval tv{};
    tv.tv_sec = timeout_ms / 1000;
    tv.tv_usec = (timeout_ms % 1000) * 1000;
    setsockopt(sock, SOL_SOCKET, SO_RCVTIMEO, (const char*)&tv, sizeof(tv));
    setsockopt(sock, SOL_SOCKET, SO_SNDTIMEO, (const char*)&tv, sizeof(tv));
    sockaddr_in addr{};
    addr.sin_family = AF_INET;
    addr.sin_port = htons(port);

    if (inet_pton(AF_INET, clean_ip.c_str(), &addr.sin_addr) <= 0) {
    #ifdef _WIN32
        closesocket(sock);
        WSACleanup();
    #else
        close(sock);
    #endif
        return false;
    }
    int result = connect(sock, (struct sockaddr*)&addr, sizeof(addr));
    #ifdef _WIN32
        closesocket(sock);
        WSACleanup();
    #else
        close(sock);
    #endif
    return (result == 0);
}

std::string readFile(const std::string& filepath) 
{
    std::ifstream file(filepath, std::ios::in | std::ios::binary);
    if (!file.is_open()) {
        return "";
    }
    std::stringstream buffer;
    buffer << file.rdbuf();
    return buffer.str();
}

bool fileExists(const std::string& filepath) 
{
    return std::filesystem::exists(filepath);
}

static const std::string BASE64_CHARS =
    "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    "abcdefghijklmnopqrstuvwxyz"
    "0123456789+/";


std::string base64encode(const std::string& input)
{
    std::string output;

    int val = 0;
    int valb = -6;
    for (unsigned char c : input)
    {
        val = (val << 8) + c;
        valb += 8;
        while (valb >= 0)
        {
            output.push_back(BASE64_CHARS[(val >> valb) & 0x3F]);
            valb -= 6;
        }
    }
    if (valb > -6)
    {
        output.push_back(
            BASE64_CHARS[((val << 8) >> (valb + 8)) & 0x3F]
        );
    }
    while (output.size() % 4)
    {
        output.push_back('=');
    }

    return output;
}

std::string base64decode(const std::string& input)
{
    std::vector<int> table(256, -1);

    for (int i = 0; i < 64; i++)
    {
        table[BASE64_CHARS[i]] = i;
    }

    std::string output;

    int val = 0;
    int valb = -8;

    for (unsigned char c : input)
    {
        if (c == '=')
            break;
        if (table[c] == -1)
        {
            throw std::runtime_error("invalid base64");
        }
        val = (val << 6) + table[c];
        valb += 6;
        if (valb >= 0)
        {
            output.push_back(char((val >> valb) & 0xFF));
            valb -= 8;
        }
    }

    return output;
}

std::string exec(const std::string& cmd)
{
    std::array<char, 128> buffer;
    std::string result;
    #ifdef _WIN32
        FILE* pipe = _popen(cmd.c_str(), "r");
    #else
        FILE* pipe = popen(cmd.c_str(), "r");
    #endif
        if (!pipe)
        {
            throw std::runtime_error("failed to open pipe");
        }

        while (fgets(buffer.data(), buffer.size(), pipe) != nullptr)
        {
            result += buffer.data();
        }

    #ifdef _WIN32
        _pclose(pipe);
    #else
        pclose(pipe);
    #endif
    return result;
}

bool writeFile(const std::string& filepath, const std::string& content)
{
    std::ofstream file(filepath, std::ios::out | std::ios::binary);

    if (!file.is_open())
    {
        return false;
    }

    file.write(content.data(), content.size());

    return file.good();
}

void printHelp()
{
    std::cout << R"(
Options:
  -h, --help       Show this help message
  -v, --version    Show version information
  -ih, --hash      Show the current installer hash

Commands:
  run
    Start the LunaUX-Decompiler local server.

  * These commands support raw bytecode or Base64-encoded bytecode

  decomp, decompile <input_file> [output_directory]
      Decompile the specified bytecode file.
      If an output directory is provided, the result will be saved there;
      otherwise, it will be printed to the console.

  disasm, disassemble <input_file> [output_directory]
      Disassemble the specified bytecode file.
      If an output directory is provided, the result will be saved there;
      otherwise, it will be printed to the console.
)";
}

const std::vector<std::string> valid_commands = {
    "decompile", 
    "disassemble", 
    "version", 
    "run",
    "hash", 
    "check", 
    "help"
};
int levenshtein(const std::string& s1, const std::string& s2) {
    int len1 = s1.size(), len2 = s2.size();
    std::vector<std::vector<int>> dp(len1 + 1, std::vector<int>(len2 + 1, 0));
    for (int i = 0; i <= len1; ++i) dp[i][0] = i;
    for (int j = 0; j <= len2; ++j) dp[0][j] = j;
    for (int i = 1; i <= len1; ++i) {
        for (int j = 1; j <= len2; ++j) {
            int cost = (s1[i-1] == s2[j-1]) ? 0 : 1;
            dp[i][j] = std::min({dp[i-1][j] + 1, dp[i][j-1] + 1, dp[i-1][j-1] + cost});
        }
    }
    return dp[len1][len2];
}

std::string findCommandSuggestion(const std::string& input) {
    if (input.empty()) return "";

    std::string best = "";
    int best_score = 999;

    for (const auto& cmd : valid_commands) {
        int distance = levenshtein(input, cmd);
        if (cmd.rfind(input, 0) == 0) {
            distance -= 3;
        }
        else if (cmd.find(input) != std::string::npos) {
            distance -= 1;
        }

        if (distance < best_score) {
            best_score = distance;
            best = cmd;
        }
    }

    return (best_score <= 5) ? best : "";
}

static inline std::string strip(std::string s) {
    s.erase(s.begin(), std::find_if(s.begin(), s.end(),
        [](unsigned char ch) { return !std::isspace(ch); }));

    s.erase(std::find_if(s.rbegin(), s.rend(),
        [](unsigned char ch) { return !std::isspace(ch); }).base(), s.end());

    return s;
}

int main(int argc, char *argv[])
{
    if (argc < 2)
    {
        printHelp();
        return 0;
    };
    std::string cmd = argv[1];
    std::transform(cmd.begin(), cmd.end(), cmd.begin(), ::tolower);
    if (cmd == "-h" || cmd == "--help")
    {
        printHelp();
    }
    else if (cmd == "-v" || cmd == "--version")
    {
        if (!fileExists("VERSION"))
        {
            std::cerr << "VERSION file not found! (Try running the installer.py file)" << std::endl;
            return 1;
        }
        std::string version = readFile("VERSION");
        if (version.empty())
        {
            std::cerr << "The VERSION file may be corrupted, try running the installer.py file" << std::endl;
            return 1;
        }
        std::cout << "LunaUX-Decompiler version: " << version << std::endl;
    } else if ( cmd == "-ih" || cmd == "--hash" )
    {
        if (!fileExists("INSTALLER"))
        {
            std::cerr << "installer file not found! (Try running the installer.py file)" << std::endl;
            return 1;
        }
        std::string hash = readFile("INSTALLER");
        if (hash.empty())
        {
            std::cerr << "The installer file may be corrupted, try running the installer.py file" << std::endl;
            return 1;
        }
        std::cout << "Current installer hash: " << hash << std::endl;
    
    } else if (cmd == "run")
    {
        if (!fileExists("installer.py"))
        {
            std::cerr << "The installer.py doesn't exists, go to our discord repo and download it!" << std::endl;
            return 1;
        }
        #ifdef _WIN32
            int result = system("python installer.py");
        #else
            int result = system("python3 installer.py");
        #endif
        if (result != 0)
        {
            std::cerr << "Failed to run installer.py" << std::endl;
            return 1;
        }
    } else if (cmd == "decompile" || cmd == "decomp")
    {
        if (argc < 3)
        {
            std::cerr << "Usage: CLI.exe decompile <input_file> <output_directory> (optional)" << std::endl;
            return 1;
        }
        std::filesystem::path input_path = argv[2];
        std::string input_file = argv[2];
        std::string output_dir;
        if (argc >= 4)
        {
            output_dir = argv[3];
        }
        if (!isUrlAvailable("http://127.0.0.1", 8000, 2500))
        {
            std::cerr << "The URL http://127.0.0.1:8000 is not accessible, make sure the LunaUX-Decompiler server is running and try again" << std::endl;
            return 1;
        }
        if (!fileExists(input_path.string()))
        {
            std::cerr << "Input file not found: " << input_file << std::endl;
            return 1;
        }
        std::string bytecode;
        try
        {
            std::string content = readFile(input_file);
            std::string decoded = base64decode(content);
            bytecode = content;
        } catch (const std::exception& e)
        {
            std::string content = readFile(input_file);
            bytecode = base64encode(content);
        }
        
        std::string filename = input_path.filename().string();
        std::string json = "{\"bytecode\": \"" + bytecode + "\", \"filename\": \"" + filename + "\"}";
        writeFile("request.json", json);
        std::string command = "curl -s -X POST \"http://127.0.0.1:8000/decompile\" -H \"Content-Type: application/json\" -d @request.json";
        try
        {
            std::string decompiled = exec(command);
            std::filesystem::remove("request.json");
            if (output_dir.empty())
            {
                std::cout << decompiled << std::endl;
            } else
            {
                try
                {  
                    std::filesystem::path output_path = output_dir;
                    writeFile(output_path.string(), decompiled);
                    std::cout << "Output saveed in path: " << output_dir << std::endl;
                
                } catch (const std::exception& e)
                {
                    std::cout << "Failed to write output: " << e.what() << std::endl;
                }
            }
        } catch (const std::exception& e)
        {
            std::cout << "An error ocurred while calling \"decompile\": " << e.what() << std::endl;
            return 1;
        }
    } else if (cmd == "dissasemble" || cmd == "disasm")
    {
        if (argc < 3)
        {
            std::cerr << "Usage: CLI.exe disassemble <input_file> <output_directory> (optional)" << std::endl;
            return 1;
        }
         std::filesystem::path input_path = argv[2];
        std::string input_file = argv[2];
        std::string output_dir;
        if (argc >= 4)
        {
            output_dir = argv[3];
        }
        if (!isUrlAvailable("http://127.0.0.1", 8000, 2500))
        {
            std::cerr << "The URL http://127.0.0.1:8000 is not accessible, make sure the LunaUX-Decompiler server is running and try again" << std::endl;
            return 1;
        }
        if (!fileExists(input_path.string()))
        {
            std::cerr << "Input file not found: " << input_file << std::endl;
            return 1;
        }
        std::string bytecode;
        try
        {
            std::string content = readFile(input_file);
            std::string decoded = base64decode(content);
            bytecode = content;
        } catch (const std::exception& e)
        {
            std::string content = readFile(input_file);
            bytecode = base64encode(content);
        }
        
        std::string filename = input_path.filename().string();
        std::string json = "{\"bytecode\": \"" + bytecode + "\", \"filename\": \"" + filename + "\"}";
        writeFile("request.json", json);

        std::string command = "curl -s -X POST \"http://127.0.0.1:8000/disassemble\" -H \"Content-Type: application/json\" -d @request.json";
        try
        {
            std::string decompiled = exec(command);
            std::filesystem::remove("request.json");
            if (output_dir.empty())
            {
                std::cout << decompiled << std::endl;
            } else
            {
                try
                {  
                    std::filesystem::path output_path = output_dir;
                    writeFile(output_path.string(), decompiled);
                    std::cout << "Output saved in path: " << output_dir << std::endl;
                
                } catch (const std::exception& e)
                {
                    std::cout << "Failed to write output: " << e.what() << std::endl;
                }
            }
        } catch (const std::exception& e)
        {
            std::cout << "An error ocurred while calling \"disassemble\": " << e.what() << std::endl;
            return 1;
        }
    } else if (cmd == "fdecomp" || cmd == "fastdecompile")
    {
        if (argc < 3)
        {
            std::cerr << "Usage: CLI.exe fdecompile <base64_bytecode> <output_directory> (optional)" << std::endl;
            return 1;
        };
        std::string bytecode = argv[2];
        bytecode = strip(bytecode);
        if (bytecode.starts_with("--"))
        {
            bytecode = bytecode.substr(2);
        }
        try
        {
            base64decode(bytecode);
        } catch (const std::exception& e)
        {
            std::cerr << "Invalid base64 bytecode" << std::endl;
            return 1;
        };
        std::string output_dir;
        if (argc >= 4)
        {
            output_dir = argv[3];
        }
        if (!isUrlAvailable("http://127.0.0.1", 8000, 2500))
        {
            std::cerr << "The URL http://127.0.0.1:8000 is not accessible, make sure the LunaUX-Decompiler server is running and try again" << std::endl;
            return 1;
        };
        std::string json = "{\"bytecode\": \"" + bytecode + "\"}";
        writeFile("request.json", json);
        std::string command = "curl -s -X POST \"http://127.0.0.1:8000/decompile\" -H \"Content-Type: application/json\" -d @request.json";
        try
        {
            std::string decompiled = exec(command);
            std::filesystem::remove("request.json");
            if (output_dir.empty())
            {
                std::cout << decompiled << std::endl;
            } else
            {
                try
                { 
                    std::filesystem::path output_path = output_dir;
                    writeFile(output_path.string(), decompiled);
                    std::cout << "Output saved in path: " << output_dir << std::endl;
                
                } catch (const std::exception& e)
                {
                    std::cout << "Failed to write output: " << e.what() << std::endl;
                }
            }
        } catch (const std::exception& e)
        {
            std::cout << "An error ocurred while calling \"fdecompile\": " << e.what() << std::endl;
            return 1;
        }
    } else if (cmd == "fdisasm" || cmd == "fastdisassemble")
    {
        if (argc < 3)
        {
            std::cerr << "Usage: CLI.exe fdisassemble <base64_bytecode> <output_directory> (optional)" << std::endl;
            return 1;
        };
        std::string bytecode = argv[2];
        bytecode = strip(bytecode);
        if (bytecode.starts_with("--"))
        {
            bytecode = bytecode.substr(2);
        }
        try
        {
            base64decode(bytecode);
        } catch (const std::exception& e)
        {
            std::cerr << "Invalid base64 bytecode" << std::endl;
            return 1;
        }
        std::string output_dir;
        if (argc >= 4)
        {
            output_dir = argv[3];
        }
        if (!isUrlAvailable("http://127.0.0.1", 8000, 2500))
        {
            std::cerr << "The URL http://127.0.0.1:8000 is not accessible, make sure the LunaUX-Decompiler server is running and try again" << std::endl;
            return 1;
        }
        std::string json = "{\"bytecode\": \"" + bytecode + "\"}";
        writeFile("request.json", json);
        std::string command = "curl -s -X POST \"http://127.0.0.1:8000/disassemble\" -H \"Content-Type: application/json\" -d @request.json";
        try
        {
            std::string decompiled = exec(command);
            std::filesystem::remove("request.json");
            if (output_dir.empty())
            {
                std::cout << decompiled << std::endl;
            } else
            {
                try
                { 
                    std::filesystem::path output_path = output_dir;
                    writeFile(output_path.string(), decompiled);
                    std::cout << "Output saved in path: " << output_dir << std::endl;
                } catch (const std::exception& e)
                {
                    std::cout << "Failed to write output: " << e.what() << std::endl;
                }
            }
        } catch (const std::exception& e)
        {
            std::cout << "An error ocurred while calling \"fdisassemble\": " << e.what() << std::endl;
            return 1;
        }
        
    } else
    {
        std::cout << "Unknown command: " << cmd << std::endl;
        std::string suggestion = findCommandSuggestion(cmd);
        if (!suggestion.empty())
        {
            std::cout << "    Did you mean: \"" << suggestion << "\" ?\n";
        }
    }
    return 0;
}