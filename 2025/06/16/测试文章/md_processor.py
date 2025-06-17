import os
import re
import datetime


def get_file_creation_time(file_path):
    """获取文件创建时间，如果无法获取则返回当前时间"""
    try:
        # 尝试获取文件创建时间
        ctime = os.path.getctime(file_path)
        return datetime.datetime.fromtimestamp(ctime).strftime("%Y-%m-%d %H:%M:%S")
    except Exception:
        # 如果无法获取创建时间，则使用当前时间
        return datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")


def extract_title_from_md(file_path):
    """从MD文件中提取标题，直接使用文件名"""
    # 直接使用文件名（不含扩展名）作为标题
    return os.path.splitext(os.path.basename(file_path))[0]


def get_tags_from_folder(folder_name):
    """从文件夹名称中提取标签"""
    folder_name = folder_name.lower()
    tags = []
    if re.search(r'python', folder_name):
        tags.append('Python')
    if re.search(r'linux', folder_name):
        tags.append('Linux')
    if re.search(r'sql', folder_name):
        tags.append('SQL')
    return tags


def add_front_matter_to_md(file_path):
    """向MD文件添加前置属性"""
    title = extract_title_from_md(file_path)
    date = get_file_creation_time(file_path)
    folder_name = os.path.basename(os.path.dirname(os.path.abspath(file_path)))
    tags = get_tags_from_folder(folder_name)

    # 构建前置属性内容
    front_matter = f"""---
title: {title}
date: {date}
categories: 笔记
tags:
"""
    for tag in tags:
        front_matter += f"  - {tag}\n"
    front_matter += "---\n\n"

    # 读取原文件内容
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
    except Exception as e:
        print(f"无法读取文件 {file_path}: {e}")
        return

    # 检查是否已经有前置属性
    if content.startswith('---\n') and '---\n' in content[4:]:
        print(f"文件 {file_path} 已经有前置属性，跳过")
        return

    # 写入新内容
    try:
        with open(file_path, 'w', encoding='utf-8') as f:
            f.write(front_matter + content)
        print(f"成功更新文件: {file_path}")
    except Exception as e:
        print(f"无法写入文件 {file_path}: {e}")


def main():
    """主函数：处理当前目录下的所有MD文件"""
    current_dir = os.getcwd()
    md_files = [f for f in os.listdir(current_dir) if f.endswith('.md')]

    if not md_files:
        print("当前目录下没有MD文件")
        return

    print(f"找到 {len(md_files)} 个MD文件")
    for md_file in md_files:
        file_path = os.path.join(current_dir, md_file)
        add_front_matter_to_md(file_path)


if __name__ == "__main__":
    main()    