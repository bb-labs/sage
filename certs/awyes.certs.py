import time


def filter_certificates(certs, domain):
    return [cert for cert in certs if cert["DomainName"] == domain].pop()
